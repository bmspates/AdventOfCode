#lang racket/gui
(provide (all-defined-out))

(define (gui-pen)
  (make-object pen% (make-object color% 255 255 102)
                        1 'solid))

(define (background-color)
  (make-object color% 15 15 35))