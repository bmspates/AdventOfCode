#lang racket
(provide (all-defined-out))

(struct binary (bits) #:transparent)

;; [Listof 0|1] -> Binary
(define (parse-binary ls)
  (make-binary ls identity))

;; [Listof Number] proc -> Binary
(define (make-binary ls proc)
  (binary (map proc ls)))

(define (get-bit b num)
  (list-ref (binary-bits b) num))

;; Maps the procedure to every bit, returning the value
;; Binary Procedure -> Binary
(define (binary-map b proc)
  (binary (map proc (binary-bits b))))

;; String -> Binary
(define (string->binary str)
  (binary (map (λ (x) (- (char->integer x) 48))
               (string->list str))))

;; Binary -> String
(define (binary->string b)
  (foldl (λ (x res) (string-append res (number->string x)))
         "" (binary-bits b)))

;; Binary -> Number
(define (binary->number b)
  (string->number (binary->string b) 2))

;; Number -> Binary
(define (number->binary n)
  (binary (map (λ (x) (- x 48)) (map char->integer
                                          (string->list (number->string n 2))))))

;; Binary Binary -> Binary
(define (binary-mult b1 b2)
  (number->binary (* (binary->number b1) (binary->number b2))))
