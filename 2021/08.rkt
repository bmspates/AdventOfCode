#lang racket
(require "input.rkt" "utils.rkt")
(provide main)

(define (parse-input ls)
  (map string-split ls))

(define (count-p1 ls)
  (match ls
    ['() 0]
    [(cons x ls) (+ (if (member x '(1 4 7 8)) 1 0) (count-p1 ls))]))
                     
(define (main)
  (let ((input (parse-input (read-lines "inputs/day8.txt"))))
    (values (solve input count-p1)
            (solve input list->number))))

(define (check-output ls nums ans)
  (foldl (λ (x res)
           (cons (index-of nums (string->set x) set=?) res)) '() ls))

(define (sets-with ls)
  (λ (x) (and (member (string-length x) ls)
              (string->set x))))

(define (determine-number nums s)
  (match (set-count s)
    [2 1] [3 7] [7 8] [4 4]
    [5 (cond [(subset? (vector-ref nums 1) s) 3]
             [(subset? (set-subtract (vector-ref nums 4) (vector-ref nums 1)) s) 5]
             [else 2])]
    [6 (cond [(not (subset? (vector-ref nums 5) s)) 0]
             [(subset? (vector-ref nums 1) s) 9]
             [else 6])]))

(define (count-line input)
  (let ((nums (build-vector 10 values)))
    (for/list ([x '((2 3 7 4) (5) (6))])
      (for/list ([s (filter-map (sets-with x) input)])
        (vector-set! nums (determine-number nums s) s)))
    (check-output (list-tail input 11) (vector->list nums) '())))

(define (solve input proc)
  (foldl + 0 (map proc (map count-line input))))
