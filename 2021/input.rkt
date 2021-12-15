#lang racket
(require "binary.rkt" "utils.rkt")
(provide (all-defined-out))

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

;; String -> [Vectorof [Vectorof Number]]
(define (read-lines->2v filename)
  (vector-map (λ (x) (string->int-vec x ""))
              (list->vector (read-lines filename))))

;; String -> [Listof Int]
(define (read-nums filename)
  (map string->number (read-lines filename)))

;; String -> [Listof Int]
(define (read-num-list filename)
  (string->int-list "," (read-line (open-input-file filename))))

;; String -> [Listof Int]
(define (read-binary-nums filename)
  (map string->number (map string-append "#b" (read-lines filename))))

;; String -> [Listof Binary]
(define (read-binary filename)
  (map string->binary
       (read-lines filename)))

;; [Listof String] -> [Listof [Listof String]]
(define (split-input filename delim)
  (split-list (read-lines filename) delim))

(define (split-list list delim)
  (map (λ (s) (string-split s delim)) list))

;; Port -> [Listof String]
(define (read-all p)
  (let ((l (read-line p)))
    (if (eof-object? l)
        '()
        (cons l (read-all p)))))

(define (strip-newlines ls)
  (match ls
    ['() '()]
    [(cons "" ls) (strip-newlines ls)]
    [(cons x ls) (cons x (strip-newlines ls))]))