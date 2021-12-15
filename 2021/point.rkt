#lang racket
(provide (all-defined-out))

(struct point (x y) #:transparent)

(define (bottom-right points)
  (point (foldl (λ (x res) (if (> (point-x x) res) (point-x x) res)) 0 points)
         (foldl (λ (x res) (if (> (point-y x) res) (point-y x) res)) 0 points)))

;; [String . String] -> Point
(define (make-point p)
  (point (string->number (car p)) (string->number (cadr p))))

(define (adj-points p r c)
  (filter (λ (x) (and (>= (point-x x) 0) (< (point-x x) r)
                      (>= (point-y x) 0) (< (point-y x) c)))
          (map (λ (x) (point (+ (car x) (point-x p)) (+ (cdr x) (point-y p))))
               (list (cons 0 1) (cons 1 0) (cons 0 -1) (cons -1 0)))))

(define (make-points r c)
  (map (λ (row) (map (λ (col) (point col row)) (range c))) (range r)))
