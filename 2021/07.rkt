#lang racket
(require "input.rkt")
(provide main)

(define (main)
  (let ((input (read-num-list "inputs/day7.txt")))
    (values (solve input identity)
            (solve input (λ (n) (/ (* n (add1 n)) 2))))))

;; Evaluates the cost for all crabs in ls to move to position i,
;;  where fc determines the fuel cost to do some number of moves
;; [Listof Number] Number (Number -> Number) -> Number
(define (cost-move-to ls i fc)
  (apply + (map (λ (x) (fc (abs (- x i)))) ls)))

(define (solve input fc)
  (foldl (λ (a res) (min res (cost-move-to input a fc)))
         (expt 2 64) (build-list (length input) values)))
(main)
