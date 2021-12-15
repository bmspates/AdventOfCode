#lang racket
(require "point.rkt")
(provide (all-defined-out))

;; While lines can be any angle, many functions are only designed
;;  for horizantal, vertical, or (maybe) 45 degree diagonals.
(struct line (p1 p2) #:transparent)

(define (line-swap l)
  (line (line-p2 l) (line-p1 l)))

(define (op-x l op)
  (op (point-x (line-p1 l)) (point-x (line-p2 l))))

(define (op-y l op)
  (op (point-y (line-p1 l)) (point-y (line-p2 l))))

(define (line-diag? l)
  (not (or (op-x l =) (op-y l =))))

(define (line-straight? l)
  (or (op-x l =) (op-y l =)))

(define (line-horizantal? l)
  (op-y l =))

(define (line-vertical? l)
  (op-x l =))

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

(define (line->point-list l)
  (if (equal? (line-p1 l) (line-p2 l))
      (list (line-p1 l))
      (cons (line-p1 l) (line->point-list (next-point l)))))

;; Point Point -> Number
(define (distance a b)
  (sqrt (+ (expt (- (point-x b) (point-x a)) 2)
           (expt (- (point-y b) (point-y a)) 2))))

;; Adds every point in the line to the set
;; Set Line -> Void
(define (set-line-union s l)
  (if (equal? (line-p1 l) (line-p2 l))
      (set-add! s (line-p1 l))
      (begin (set-add! s (line-p1 l)) (set-line-union s (next-point l)))))

(define (point-on-line? l p)
  (= (distance (line-p1 l) (line-p2 l))
     (+ (distance p (line-p1 l))
        (distance p (line-p2 l)))))

;; a and b are assumed to be intersecting and both either horiz or vert.
;; Line Line Set -> Void
(define (add-overlap-intersect a b s)
  (begin
    (cond
      [(equal? (line-p1 a) (line-p2 a))
       (set-add! s (line-p1 a))]
      [(or (and (line-horizantal? a) (line-horizantal? b))
           (and (line-vertical? a) (line-vertical? b)))
       (if (point-on-line? b (line-p1 a))
           (begin (set-add! s (line-p1 a))
                  (if (not (point-on-line? b (line-p1 (next-point a))))
                      (void)
                      (add-overlap-intersect (next-point a) b s)))
           (add-overlap-intersect (line-swap a) b s))]
      [else (if (point-on-line? b (line-p1 a))
             (set-add! s (line-p1 a))
             (add-overlap-intersect (line-swap a) b s))])
    (void)))
 
;; Line Line Set -> Void
(define (line-intersections l1 l2 s)
  (begin
    (cond
      [(equal? l1 l2) (set-line-union (s l1))]
      [(and (point-on-line? l1 (line-p1 l2)) (point-on-line? l1 (line-p2 l2)))
       (set-line-union s l2)]
      [(and (point-on-line? l2 (line-p1 l1)) (point-on-line? l2 (line-p2 l1)))
       (set-line-union s l1)]
      [(or (point-on-line? l1 (line-p1 l2)) (point-on-line? l1 (line-p2 l2)))
       (add-overlap-intersect l1 l2 s)]
      [(or (point-on-line? l2 (line-p1 l1)) (point-on-line? l2 (line-p2 l1)))
       (add-overlap-intersect l2 l1 s)])
    (void)))

(define (intersection-list a b)
  (begin
    (define s (mutable-set))
    (line-intersections a b s)
    (set->list s)))