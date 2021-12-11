#lang racket
(provide (all-defined-out))

;; [Listof [Listof X]] -> [Listof [Listof X]]
(define (transpose ls)
  (apply map list ls))

;; [Listof [Listof X]] (X -> Number) -> Number
;; Applies proc to then sums all of the given lists
(define (sum-lists-map ls proc)
  (define/match (helper ls sum)
    [('() _) sum]
    [((cons x ls) _) (helper ls (map + (map proc x) sum))])
  (helper ls (make-list (length (car ls)) 0)))

;; [Listof [Listof Number]] -> [Listof Number]
;; Adds all of the given lists together
;; Ex: (sum-lists '((1 2 3) (4 5 6))) -> '(5 7 9)
(define (sum-lists ls)
  (define (helper ls sum)
      (match ls
    ['() sum]
    [(cons x ls) (helper ls (map + x sum))]))
  (helper (cdr ls) (car ls)))

;; [Listof X] -> X
;; Assumes there is a odd number of entries
(define (find-midpoint ls)
  (list-ref ls (floor (/ (length ls) 2))))

;; String String -> [Listof Number]
;; Ex: (string->int-list "," "1,2,3") -> '(1 2 3)
(define (string->int-list sep s)
  (map string->number (filter non-empty-string? (string-split s sep))))

;; String String -> [Vectorof Number]
;; Ex: (string->int-vec "," "1,2,3") -> '#(1 2 3)
(define (string->int-vec s sep)
  (vector-map string->number (vector-filter non-empty-string? (list->vector (string-split s sep)))))

;; String -> {Setof Char}
(define (string->set s)
  (list->set (string->list s)))

;; [Listof Number] -> Number
;; Ex: (list->number '(1 2 3)) -> 321
(define (list->number x)
  (string->number (list->string (reverse (map (λ (a) (integer->char (+ 48 a))) x)))))

;; [Listof [Listof X]] Number Number Y -> X | Y
(define (list-ref2 input r c [default #f])
  (if (and (<= 0 r) (<= 0 c) (> (length input) r) (> (length (list-ref input 0)) c))
      (list-ref (list-ref input r) c)
      default))

;; [Vectorof [Vectorof X]] Number Number X -> Void
(define (set2v! vec r c value)
  (if (and (<= 0 r) (<= 0 c) (> (vector-length vec) r) (> (vector-length (vector-ref vec 0)) c))
      (vector-set! (vector-ref vec r) c value)
      (void)))

;; [Vectorof [Vectorof X]] Number Number Y -> X | Y
(define (get2v vec r c [default #f])
  (if (and (<= 0 r) (<= 0 c) (> (vector-length vec) r) (> (vector-length (vector-ref vec 0)) c))
      (vector-ref (vector-ref vec r) c)
      default))

(define (map2v proc vec)
  (for ((row (vector-length vec)))
    (vector-map! proc (vector-ref vec row))))

;; [Vectorof [Vectorof X]] Number Number (X -> Y) -> Y
(define (update2v vec r c proc [default #f])
  (if (and (<= 0 r) (<= 0 c) (> (vector-length vec) r) (> (vector-length (vector-ref vec r)) c))
      (and (set2v! vec r c (proc (vector-ref (vector-ref vec r) c)))
           (vector-ref (vector-ref vec r) c))
      default))

(define (length2v vec)
  (* (vector-length vec) (vector-length (vector-ref vec 0))))

(define (while cond body)
  (when (cond)
    (body)
    (while cond body)))