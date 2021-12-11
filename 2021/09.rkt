#lang racket
(require "input.rkt" "utils.rkt")
(provide main)
                     
(define (main)
  (let ((input (read-lines->2v "inputs/day9.txt")))
    (values (part-one input)
            (part-two input))))

(define (low-point input r c)
  (let ((val (get2v input r c)))
    (foldl (λ (x res)
             (and res (match (get2v input (+ r (car x)) (+ c (cdr x)) 10)
                        [#f #t]
                        [x (> x val)])))
           #t '((1 . 0) (-1 . 0) (0 . 1) (0 . -1)))))

(define (count-fill input r c)
  (match (get2v input r c 9)
    [9 0]
    [x (begin (set2v! input r c 9)
              (+ 1
                 (count-fill input (add1 r) c)
                 (count-fill input (sub1 r) c)
                 (count-fill input r (add1 c))
                 (count-fill input r (sub1 c))))]))

(define (part-two input)
  (let ((s (mutable-set)))
    (for ((r (vector-length input)))
      (for ((c (vector-length (vector-ref input r))))
        (set-add! s (count-fill input r c))))
    (apply * (take (sort (set->list s) >) 3))))

(define (part-one input)
  (let ((b (box 0)))
    (for ((r (vector-length input)))
      (for ((c (vector-length (vector-ref input r))))
        (if (low-point input r c)
            (set-box! b (+ (unbox b) (add1 (get2v input r c))))
            (void))))
    (unbox b)))