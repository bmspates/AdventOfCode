#lang racket
(require "binary.rkt")
(provide read-lines read-nums split-input read-binary-nums read-binary read-num-lines)

;; Int File -> [Listof String]
(define (read-num-lines n p)
  (let ((l (read-line p)))
    (if (eof-object? l)
        '()
        (if (= n 1)
            (cons l '())
            (cons l (read-num-lines (sub1 n) p))))))

;; String -> [Listof String]
(define (read-lines filename)
  (let ((p (open-input-file filename)))
    (read-all p)))

;; String -> [Listof Int]
(define (read-nums filename)
  (map string->number (read-lines filename)))

;; String -> [Listof Int]
(define (read-binary-nums filename)
  (map string->number (map string-append "#b" (read-lines filename))))

;; String -> [Listof Binary]
(define (read-binary filename)
  (map string->binary
       (read-lines filename)))

;; [Listof String] -> [Listof [Listof String]]
(define (split-input filename delim)
  (map (λ (s) (string-split s delim)) (read-lines filename)))

(define (read-all p)
  (let ((l (read-line p)))
    (if (eof-object? l)
        '()
        (cons l (read-all p)))))