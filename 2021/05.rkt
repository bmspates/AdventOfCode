#lang racket/gui
(require "input.rkt" "utils.rkt" "line.rkt" "gui.rkt")
(provide main)

(define (main)
  (let ((input (parse-inputs (read-lines "inputs/day5.txt"))))
    (values (solve input #f)
            (solve input #t)
            (visualize input))))

(define (parse-inputs ls)
  (match ls
    ['() '()]
    [(cons l ls)
     (let ([points (map (lambda (x) (string-split x ",")) (string-split l " -> "))])
       (cons (line (make-point (car points)) (make-point (cadr points)))
             (parse-inputs ls)))]))

(define (solve input diag?)
  (let ([h (make-hash)])
    (begin
      (for/list ([l input])
        (add-points l h diag?))
      (count-overlap h 2))))


(define (add-points l h diag?)
  (if (and (not diag?) (line-diag? l))
      (void)
      (let ([p1 (line-p1 l)]
            [p2 (line-p2 l)])
        (if (equal? p1 p2)
            (begin (hash-update! h p1 add1 0) (void))
            (begin (hash-update! h p1 add1 0)
                   (add-points (next-point l) h diag?))))))

(define (count-overlap h n)
  (foldl (lambda (x res) (if (<= n x) (add1 res) res))
         0
         (hash-values h)))

(define (visualize ls)
  (begin
    (define frame (new frame%
                   [label "AoC Day 5"]
                   [width (+ (max-x ls) 5)]
                   [height (+ (max-y ls) 5)]))
    (new canvas% [parent frame]
             [paint-callback
              (lambda (canvas dc)
                (begin
                  (send dc set-pen (gui-pen))
                  (send canvas set-canvas-background (background-color))
                  (for/list ([l ls])
                    (let ([p1 (line-p1 l)]
                          [p2 (line-p2 l)])
                      (send dc draw-line (point-x p1) (point-y p1) (point-x p2) (point-y p2))))))])
    (send frame show #t)))