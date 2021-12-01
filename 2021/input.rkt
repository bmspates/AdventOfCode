#lang racket
(provide read-lines read-nums)

;; String -> [Listof String]
(define (read-lines filename)
  (let ((p (open-input-file filename)))
    (read-all p)))

;; String -> [Listof Int]
(define (read-nums filename)
  (map string->number (read-lines filename)))

(define (read-all p)
  (let ((l (read-line p)))
    (if (eof-object? l)
        '()
        (cons l (read-all p)))))