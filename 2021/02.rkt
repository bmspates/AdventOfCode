#lang racket
(require "input.rkt")
(provide main)

(define (main)
  (let ((input (split-input "inputs/day2.txt" " ")))
	(values (part-one input 0 0)
                (part-two input 0 0 0))))

(define (part-one input depth dist)
  (match input
    ['() (* depth dist)]
    [(cons (list dir d) ls)
     (let ([d (string->number d)])
       (match dir
         ["forward" (part-one ls depth (+ dist d))]
         ["down" (part-one ls (+ depth d) dist)]
         ["up" (part-one ls (- depth d) dist)]))]))

(define (part-two input depth dist aim)
  (match input
    ['() (* depth dist)]
    [(cons (list dir d) ls)
     (let ([d (string->number d)])
       (match dir
         ["forward" (part-two ls (+ depth (* aim d)) (+ dist d) aim)]
         ["down" (part-two ls depth dist (+ aim d))]
         ["up" (part-two ls depth dist (- aim d))]))]))
