#lang racket
(require "input.rkt" "utils.rkt")
(provide main)

(define (parse-board ls)
  (match ls
    ['() '()]
    [(cons str rem) (cons (string->int-list " " str) (parse-board rem))]
    [str (cons str '())]))

(define (parse-boards file)
  (if (empty? (read-num-lines 1 file))
      '()
      (let ((board (parse-board (read-num-lines 5 file))))
        (cons board (parse-boards file)))))

(define (parse-input file)
  (let ([nums (string->int-list "," (car (read-num-lines 1 file)))])
    (list nums (parse-boards file))))
    
(define (main)
  (match (parse-input (open-input-file "inputs/day4.txt"))
    [(list* nums boards)
     (values (part-one nums (car boards))
             (part-two nums (car boards)))]))

(define (row? board row-num nums)
  (andmap (λ (x) (member x nums)) (list-ref board row-num)))

(define (bingo? board tboard nums i)
  (if (= i 5) #f
      (if (or (row? board i nums) (row? tboard i nums))
          #t
          (bingo? board tboard nums (add1 i)))))

(define (bingos boards nums)
  (match boards
    ['() '()]
    [(cons b ls) (if (bingo? b (transpose b) nums 0) (cons b (bingos ls nums)) (bingos ls nums))]))

(define (score board nums i sum)
  (if (= i 5)
      (* (last nums) sum)
      (score board nums (add1 i)
             (foldl (λ (x res)
                      (+ res (if (member x nums) 0 x)))
                    sum
                    (list-ref board i)))))

(define (step nums boards i)
  (let ((picks (take nums i)))
    (match (bingos boards picks)
      ['() (step nums boards (add1 i))]
      [(cons a ls) (score a picks 0 0)])))

(define (part-one nums boards)
  (step nums boards 0))

(define (step-last nums lose i)
  (let ((picks (take nums i)))
    (match (length lose)
      [1 (if (bingo? (car lose) (transpose (car lose)) picks 0)
             (score (car lose) picks 0 0)
             (step-last nums lose (add1 i)))]
      [_ (step-last nums
                    (filter (λ (b) (not (bingo? b (transpose b) picks 0))) lose)
                    (add1 i))])))

(define (part-two nums boards)
  (step-last nums boards 0))
