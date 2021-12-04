#lang racket
(provide make-binary parse-binary sum-lists string->int-list transpose)

;; [Listof [Listof _]] -> [Listof [Listof _]]
(define (transpose ls)
  (apply map list ls))

;; [Listof Integer] -> Integer
(define (parse-binary ls)
  (make-binary ls identity))

;; [Listof Integer] Procedure -> Integer
(define (make-binary ls proc)
  (string->number
   (string-append "#b" (list->string
                        (map (lambda (x) (integer->char (+ 48 x)))
                             (map proc ls))))))

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