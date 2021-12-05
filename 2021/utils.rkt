#lang racket
(provide sum-lists string->int-list transpose)

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
  (sum-lists_ (cdr ls) (car ls)))

(define (sum-lists_ ls sum)
  (match ls
    ['() sum]
    [(cons x ls) (sum-lists_ ls (map + x sum))]))

(define (string->int-list s sep)
  (map string->number (filter non-empty-string? (string-split s sep))))