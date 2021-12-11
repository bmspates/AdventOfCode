#lang racket
(require "input.rkt" "utils.rkt")
(provide main)

(define (main)
  (let ((input (map string->list (read-lines "inputs/day10.txt"))))
    (solve input)))

(define (solve input)
  (let ((ls (map test-line input)))
    (values (apply + (filter number? ls))
            (find-midpoint (sort (map score-string (filter string? ls)) >)))))

(define (close x) (match x [#\( #\)] [#\{ #\}] [#\[ #\]] [#\< #\>]))

(define (test-line ls)
  ;; Helper checks the block starting at open, returns:
  ;;  - The remainder of the line if the block is complete
  ;;  - The score of the corrupt element if the block was corrupt
  ;;  - The string to complete the block if it is incomplete
  (define (helper ls open) 
    (match ls
      ['() (string (close open))] ;; Incomplete
      [(cons x ls)
       (match x
         [(or #\( #\{ #\< #\[)
          (match (helper ls x)
            [(? string? s) (~a s (close open))] ;; Incomplete
            [(? number? n) n] ;; Corrupt
            [ls (helper ls open)])] ;; Block ended, check next block
         [(or #\) #\} #\> #\])
          (if (equal? (close open) x)
              ls ;; End of Block
              (match x [#\) 3] [#\] 57] [#\} 1197] [#\> 25137]) ;; Corrupt
              )])]))
  (helper (cdr ls) (car ls)))

(define (score-string s)
  (foldl (λ (x res) (+ (* 5 res) (match x [#\) 1] [#\] 2] [#\} 3] [#\> 4])))
         0 (string->list s)))