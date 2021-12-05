#lang racket
(provide (all-defined-out))

(struct point (x y) #:transparent)
(struct line (p1 p2) #:transparent)

(define (make-point p)
  (point (string->number (car p)) (string->number (cadr p))))

(define (op-x l op)
  (op (point-x (line-p1 l)) (point-x (line-p2 l))))

(define (op-y l op)
  (op (point-y (line-p1 l)) (point-y (line-p2 l))))

(define (line-diag? l)
  (not (or (op-x l =) (op-y l =))))

(define (line-straight? l)
  (or (op-x l =) (op-y l =)))

(define (next-point l)
  (let* ([p1 (line-p1 l)]
         [p2 (line-p2 l)]
         [p1_x (point-x p1)]
         [p1_y (point-y p1)])
    (cond
      [(and (op-x l =) (op-y l >)) ;; p1_x = p2_x and p1_y > p2_y
       (line (point p1_x (sub1 p1_y)) p2)]
      [(and (op-x l =) (op-y l <)) ;; p1_x = p2_x and p1_y < p2_y
       (line (point p1_x (add1 p1_y)) p2)]
      [(and (op-x l >) (op-y l =)) ;; p1_x > p2_x and p1_y = p2_y
       (line (point (sub1 p1_x) p1_y) p2)]
      [(and (op-x l <) (op-y l =)) ;; p1_x < p2_x and p1_y = p2_y
       (line (point (add1 p1_x) p1_y) p2)]
      [(and (op-x l >) (op-y l >)) ;; p1_x > p2_x and p1_y > p2_y
       (line (point (sub1 p1_x) (sub1 p1_y)) p2)]
      [(and (op-x l >) (op-y l <)) ;; p1_x > p2_x and p1_y < p2_y
       (line (point (sub1 p1_x) (add1 p1_y)) p2)]
      [(and (op-x l <) (op-y l >)) ;; p1_x < p2_x and p1_y > p2_y
       (line (point (add1 p1_x) (sub1 p1_y)) p2)]
      [(and (op-x l <) (op-y l <)) ;; p1_x < p2_x and p1_y < p2_y
       (line (point (add1 p1_x) (add1 p1_y)) p2)])))

(define (max-x ls)
  (define/match (helper ls val)
    [('() _) val]
    [((cons (line p1 p2) ls) _) (helper ls (max val (point-x p1) (point-x p2)))])
  (helper ls 0))

(define (max-y ls)
  (define/match (helper ls val)
    [('() _) val]
    [((cons (line p1 p2) ls) _) (helper ls (max val (point-y p1) (point-y p2)))])
  (helper ls 0))