#lang racket
(require "input.rkt" "utils.rkt")
(provide main)

(define (main)
  (let ((input (read-lines "inputs/day_.txt")))
    (values (part-one input)
            (part-two input))))

(define (part-one input)
  0)

(define (part-two input)
  0)
