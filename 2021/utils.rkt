#lang racket
(provide (all-defined-out))

;; [Listof [Listof _]] -> [Listof [Listof _]]
(define (transpose ls)
  (apply map list ls))

(define (sum-lists-map ls proc)
  (define/match (helper ls proc sum)
    [('() _ _) sum]
    [((cons x ls) _ _) (helper ls (map + (map proc x) sum))])
  (helper ls proc 0))

;; Sums each element listwise
;; [Listof [Listof Integer]] -> [Listof Integer]
(define (sum-lists ls)
  (define (helper ls sum)
      (match ls
    ['() sum]
    [(cons x ls) (helper ls (map + x sum))]))
  (helper (cdr ls) (car ls)))

(define (string->int-list s sep)
  (map string->number (filter non-empty-string? (string-split s sep))))

(define (string->set s)
  (list->set (string->list s)))

(define (list->number x)
  (string->number (list->string (reverse (map (λ (x) (integer->char (+ 48 x))) x)))))