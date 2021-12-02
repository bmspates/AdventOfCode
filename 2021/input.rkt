#lang racket
(provide read-lines read-nums split-input)

;; String -> [Listof String]
(define (read-lines filename)
  (let ((p (open-input-file filename)))
    (read-all p)))

;; String -> [Listof Int]
(define (read-nums filename)
  (map string->number (read-lines filename)))

;; [Listof String] -> [Listof [Listof String]]
(define (split-input filename delim)
  (map (lambda (s) (string-split s delim)) (read-lines filename)))

(define (read-all p)
  (let ((l (read-line p)))
    (if (eof-object? l)
        '()
        (cons l (read-all p)))))