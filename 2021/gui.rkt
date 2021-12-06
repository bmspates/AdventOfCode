#lang racket/gui
(provide (all-defined-out))

(define (gui-pen)
  (make-object pen% (fg-color) 1 'solid))

(define (bg-color)
  (make-object color% 15 15 35))

(define (fg-color)
  (make-object color% 255 255 102))

;; Only works for square data sets
;; Frame [Listof [Listof String]] -> Void
(define (show-table frame data [show? #t])
  (define table (new list-box%
                 [parent frame]
                 [choices (list)]
                 [label ""]
                 [style (list 'single 'variable-columns)]
                 [columns (build-list (length data) number->string)]))
  (send/apply table set data)
  (send frame show show?))

;; Number Number Number -> Frame
(define (new-frame w h day)
  (new frame%
       [label (string-append "Advent of Code | Day " (number->string day))]
       [width w]
       [height h]))

;; Frame Procedure -> Canvas
(define (new-canvas frame callback)
  (new canvas% [parent frame] [paint-callback callback]))