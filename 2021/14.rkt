#lang racket
(require "input.rkt" "utils.rkt")
(provide main)

(define (parse-bindings ls)
  (make-hash
   (map (λ (x) (cons (cons (string-ref (car x) 0) (string-ref (car x) 1))
                     (string-ref (cadr x) 0)))
        (map (λ (y) (string-split y " -> ")) ls))))

(define (parse-input ls)
  (define h (make-hash))
  (define (helper ls)
    (match ls
      ['() h]
      [(cons x '()) h]
      [(list* a b ls) (and (hash-update! h (cons a b) add1 0)
                           (helper (cons b ls)))]))
  (helper ls))

(define (parse-counts ls)
  (define counts (make-hash))
  (define (helper ls)
    (match ls
      ['() counts]
      [(cons x ls) (and (hash-update! counts x add1 0) (helper ls))]))
  (helper ls))

(define (main)
  (let* ((input (read-lines "inputs/day14.txt"))
         (pairs (parse-input (string->list (first input))))
         (bindings (parse-bindings (drop input 2)))
         (counts (parse-counts (string->list (first input)))))
    (step pairs counts bindings 40)))


(define (step pairs counts bindings n)
  (if (= 0 n)
      (let ((min (argmin cdr (hash->list counts)))
            (max (argmax cdr (hash->list counts))))
        (- (cdr max) (cdr min)))
      (let ((np (make-hash)))
        (for/list ((p (hash->list pairs)))
          (match (hash-ref bindings (car p) #f)
            [#f (hash-update! np (car p) add1 0)]
            [y (begin (hash-update! np (cons (caar p) y) (λ (x) (+ x (cdr p))) 0)
                      (hash-update! np (cons y (cdar p)) (λ (x) (+ x (cdr p))) 0)
                      (hash-update! counts y (λ (x) (+ x (cdr p))) 0))]))
        (step np counts bindings (sub1 n)))))
      