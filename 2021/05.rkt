#lang racket
(require "input.rkt" "utils.rkt" "line.rkt")
(provide main)

(define (main)
  (let ((input (parse-inputs (read-lines "inputs/day5.txt"))))
    (values (solve input #f)
            (solve input #t))))

(define (parse-inputs ls)
  (match ls
    ['() '()]
    [(cons l ls)
     (let ([points (map (lambda (x) (string-split x ",")) (string-split l " -> "))])
       (cons (Line (make-point (car points)) (make-point (cadr points)))
             (parse-inputs ls)))]))

(define (solve input diag?)
  (let ([h (make-hash)])
    (begin
      (for/list ([line input])
        (add-points line h diag?))
      (count-overlap h 2))))


(define (add-points line h diag?)
  (if (not (or (op-x line =) (op-y line =) diag?))
      (void)
      (let ([p1 (Line-p1 line)]
            [p2 (Line-p2 line)])
        (if (equal? p1 p2)
            (begin (hash-update! h p1 add1 0) (void))
            (begin (hash-update! h p1 add1 0)
                   (add-points (next-point line) h diag?))))))

(define (count-overlap h n)
  (foldl (lambda (x res) (if (<= n x) (add1 res) res))
         0
         (hash-values h)))
