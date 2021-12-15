#lang racket
(require "input.rkt" "utils.rkt")
(require graph)
(provide main)

(define p1 (mutable-set))
(define p2 (mutable-set))

(define (main)
  (let* ((input (split-input "inputs/day12.txt" "-"))
         (g (unweighted-graph/undirected input)))
    (values (part-one g)
            (part-two g))))

(define (per g v seen 2? p)
  (if (equal? v "end")
      (set-add! p (cons v seen))
      (for ((n (get-neighbors g v)))
        (when (not (equal? n "start"))
          (cond
            [(or (upcase? n) (not (member n seen)))
             (per g n (cons v seen) 2? p)]
            [(and (downcase? n) (member n seen) (not 2?))
             (per g n (cons v seen) #t p)])))))

(define (part-one g)
  (per g "start" '() #t p1)
  (set-count p1))

(define (part-two g)
  (per g "start" '() #f p2)
  (set-count p2))
