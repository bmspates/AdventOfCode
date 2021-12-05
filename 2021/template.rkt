#lang racket/gui
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

(define (visualize ls)
  (begin
    (define frame (new frame%
                   [label "AoC Day _"]
                   [width 1000]
                   [height 1000]))
    (new canvas% [parent frame]
             [paint-callback
              (lambda (canvas dc)
                (begin (send dc set-pen (gui-pen))
                       (send canvas set-canvas-background (background-color))))])
    (send frame show #t)))