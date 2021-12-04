#lang racket
(require "input.rkt" "utils.rkt")
(provide main)

(define (parse-board ls)
  (match ls
    ['() '()]
    [(cons str rem) (cons (string->int-list str " ") (parse-board rem))]
    [str (cons str '())]))

(define (parse-boards file)
  (if (empty? (read-num-lines 1 file))
      '()
      (let ((board (parse-board (read-num-lines 5 file))))
        (cons board (parse-boards file)))))

(define (parse-input file)
  (let ([nums (string->int-list (car (read-num-lines 1 file)) ",")])
    (list nums (parse-boards file))))
    
(define (main)
  (match (parse-input (open-input-file "inputs/day4.txt"))
    [(list* nums boards)
     (values (part-one nums (car boards))
             (part-two nums (car boards)))]))

(define (row? board row-num nums)
  (andmap (lambda (x) (member x nums)) (list-ref board row-num)))

(define (col? board col-num nums i)
  (if (= i 5) #t
      (if (member (list-ref (list-ref board i) col-num) nums)
          (col? board col-num nums (add1 i))
          #f)))

(define (bingo? board nums i)
  (if (= i 5) #f
      (if (or (row? board i nums) (col? board i nums 0))
          #t
          (bingo? board nums (add1 i)))))

(define (bingos boards nums)
  (match boards
    ['() '()]
    [(cons b ls) (if (bingo? b nums 0) (cons b (bingos ls nums)) (bingos ls nums))]))

(define (score board nums i sum)
  (if (= i 5)
      (* (last nums) sum)
      (score board nums (add1 i)
             (foldl (lambda (x res)
                      (+ res (if (member x nums) 0 x)))
                    sum
                    (list-ref board i)))))

(define (step nums boards i)
  (match (bingos boards (take nums i))
    ['() (step nums boards (add1 i))]
    [(cons a ls) (score a (take nums i) 0 0)]))

(define (part-one nums boards)
  (step nums boards 0))

(define (step-last nums lose i)
  (match (length lose)
    [1 (if (bingo? (car lose) (take nums i) 0)
           (score (car lose) (take nums i) 0 0)
           (step-last nums lose (add1 i)))]
    [_ (step-last nums (filter (lambda (b) (not (bingo? b (take nums i) 0))) lose) (add1 i))]))

(define (part-two nums boards)
  (step-last nums boards 0))
