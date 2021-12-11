#lang racket
(require "input.rkt" "utils.rkt")
(provide main)

(define (main)
  (let ((input (read-lines->2v "inputs/day11.txt")))
    (solve input 100)))

(define adjs '((-1 . -1) (-1 . 0) (-1 . 1) (0 . -1) (0 . 1) (1 . -1) (1 . 0) (1 . 1)))

(define (solve input num-steps)
  (let ((num-flashes (box 0))
        (all-flash (box 0))
        (can-flash (make-hash)))
    
    (define (flash row col)
      (set-box! num-flashes (add1 (unbox num-flashes)))
      (hash-set! can-flash (cons row col) #f)
      (for/list ((a adjs))
        (update2v input (+ (car a) row) (+ (cdr a) col) add1))
      (for/list ((a adjs))
        (let ((x (+ (car a) row)) (y (+ (cdr a) col)))
          (when (and (< 9 (get2v input x y 0))
                     (hash-ref can-flash (cons x y) #t))
            (flash x y)))))
    
    (define (step i)
      (map2v add1 input) ;; Add 1 to each octopus
      (for ([row (vector-length input)]) ;; Flash octopuses greater than 9 that can flash
        (for ([col (vector-length (vector-ref input row))])
          (when (and (< 9 (get2v input row col)) (hash-ref can-flash (cons row col) #t))
            (flash row col))))
      (map2v (λ (x) (if (< 9 x) 0 x)) input) ;; Set ones that flashed back to 0
      (when (= (length2v input) (length (hash-values can-flash)))
        (set-box! all-flash (add1 i)))
      (hash-clear! can-flash))
    
    (define (flash-all i) ;; Keep stepping until all octopuses flash
      (step i)
      (when (= 0 (unbox all-flash)) (flash-all (add1 i))))
    
    (for ((i num-steps)) (step i)) ;; Part One
    (let ((ans (unbox num-flashes))) ;; Save p1 answer
      (flash-all num-steps) ;; Part Two
      (values ans (unbox all-flash)))))  
