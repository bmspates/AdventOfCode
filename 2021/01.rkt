#lang racket
(require "input.rkt")
(provide main) 

(define (main)
  (let ((input (read-nums "inputs/day1.txt")))
    (values (part-one input)
            (part-two input -1))))

(define (part-one input)
  (match input
    [(list a b) (if (> b a) 1 0)]
    [(list* a b ls) (+ (if (> b a) 1 0) (part-one (rest input)))]))

(define (part-two input prev)
  (match input
    [(list* a b c ls)
     (let ((sum (+ a b c)))
       (if (= prev -1)
           (part-two input sum)
           (if (> sum prev)
               (+ 1 (part-two (rest input) sum))
               (part-two (rest input) sum))))]
    [_ 0]))
