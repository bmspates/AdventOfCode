#lang racket
(require "input.rkt" "utils.rkt" "line.rkt") ;; TODO refactor the point struct
(require graph)                              ;; out of line and into it's own file
(provide main)

(define (adj-points p r c)
  (filter (λ (x) (and (>= (point-x x) 0) (< (point-x x) r)
                      (>= (point-y x) 0) (< (point-y x) c)))
          (map (λ (x) (point (+ (car x) (point-x p)) (+ (cdr x) (point-y p))))
               (list (cons 0 1) (cons 1 0) (cons 0 -1) (cons -1 0)))))


(define (add-modulo a b m)
  (modulo (+ a b) m))

(define (parse-input part ls)
  (define weights
    (if (equal? part 'p1) (map (string->int-list "") ls)
        (let ((b (box '())))
          (for ((row 5))
            (let ((b2 (box '())))
              (for ((col 5))
                (set-box! b2 (cons
                              (map (λ (x)
                                     (map (λ (y) (add-modulo y (+ row col) 10))
                                          x))
                                   ls)
                              (unbox b2))))
              (set-box! b (cons (unbox b2) (unbox b)))))
          (unbox b))))
  (define (make-points r c)
    (map (λ (row) (map (λ (col) (point col row)) (range c))) (range r)))
  (define (make-weights r c)
    (let ((h (make-hash)))
      (for/list ((row (make-points r c)))
        (for/list ((p row))
          (hash-set! h p (list-ref
                          (list-ref weights (point-y p))
                          (point-x p)))))
      h))
  (define (make-paths r c)
    (let ((b (box '()))
          (h (make-weights r c)))
      (for/list ((row (make-points r c)))
        (for/list ((p row))
          (for/list ((n (adj-points p r c)))
            (set-box! b (cons (list (hash-ref h n) p n)
                              (unbox b))))))
      (unbox b)))
  (weighted-graph/directed (make-paths (* (if (equal? part 'p1) 1 5)
                                          (length ls))
                                       (*(if (equal? part 'p1) 1 5)
                                         (string-length (list-ref ls 0))))))

(define (main)
  (let ((g (parse-input 'p1 (read-lines "inputs/day15test.txt"))))
    (let-values ([(cost pred) (dijkstra g (point 0 0))])
      (hash-ref cost (bottom-right (get-vertices g))))))
