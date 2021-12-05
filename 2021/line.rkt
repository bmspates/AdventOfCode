#lang racket
(provide (all-defined-out))

(struct Point (x y) #:transparent)
(struct Line (p1 p2) #:transparent)

(define (make-point p)
  (Point (string->number (car p)) (string->number (cadr p))))

(define (op-x line op)
  (op (Point-x (Line-p1 line)) (Point-x (Line-p2 line))))

(define (op-y line op)
  (op (Point-y (Line-p1 line)) (Point-y (Line-p2 line))))

(define (next-point line)
  (let* ([p1 (Line-p1 line)]
         [p2 (Line-p2 line)]
         [p1_x (Point-x p1)]
         [p1_y (Point-y p1)])
    (cond
      [(and (op-x line =) (op-y line >)) ;; p1_x = p2_x and p1_y > p2_y
       (Line (Point p1_x (sub1 p1_y)) p2)]
      [(and (op-x line =) (op-y line <)) ;; p1_x = p2_x and p1_y < p2_y
       (Line (Point p1_x (add1 p1_y)) p2)]
      [(and (op-x line >) (op-y line =)) ;; p1_x > p2_x and p1_y = p2_y
       (Line (Point (sub1 p1_x) p1_y) p2)]
      [(and (op-x line <) (op-y line =)) ;; p1_x < p2_x and p1_y = p2_y
       (Line (Point (add1 p1_x) p1_y) p2)]
      [(and (op-x line >) (op-y line >)) ;; p1_x > p2_x and p1_y > p2_y
       (Line (Point (sub1 p1_x) (sub1 p1_y)) p2)]
      [(and (op-x line >) (op-y line <)) ;; p1_x > p2_x and p1_y < p2_y
       (Line (Point (sub1 p1_x) (add1 p1_y)) p2)]
      [(and (op-x line <) (op-y line >)) ;; p1_x < p2_x and p1_y > p2_y
       (Line (Point (add1 p1_x) (sub1 p1_y)) p2)]
      [(and (op-x line <) (op-y line <)) ;; p1_x < p2_x and p1_y < p2_y
       (Line (Point (add1 p1_x) (add1 p1_y)) p2)])))
