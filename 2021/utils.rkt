#lang racket
(provide make-binary parse-binary sum-lists)

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
