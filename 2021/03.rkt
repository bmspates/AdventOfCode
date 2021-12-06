#lang racket/gui
(require "input.rkt" "utils.rkt" "binary.rkt")
(provide main)

(define (main)
  (let ((input (read-binary "inputs/day3.txt")))
    (values (part-one input)
            (part-two input))))

(define (sum-binary-list ls)
   (define (helper ls sum)
     (match ls
       ['() sum]
       [(cons x ls) (helper ls (map + (binary-bits x) sum))]))
   (helper (cdr ls) (binary-bits (car ls))))

(define (part-one input)
  (let* ([sum (sum-binary-list input)]
         [half (/ (length input) 2)]
         [gamma (make-binary sum (λ (x) (if (> x half) 1 0)))]
         [epsilon (make-binary sum (λ (x) (if (> x half) 0 1)))])
    (binary->number (binary-mult gamma epsilon))))

;; Counts the most (or least) common bit value for ls[bit-num]
;; If an equal number of 1's and 0's are found, default is returned,
;;  otherwise proc determines which bit to return
(define (common-value ls bit-num c0 c1 proc default)
  (match ls
    ['() (if (= c0 c1) default (if (proc c0 c1) 0 1))]
    [(cons b ls)
     (match (get-bit b bit-num)
       [0 (common-value ls bit-num (add1 c0) c1 proc default)]
       [1 (common-value ls bit-num c0 (add1 c1) proc default)])]))

;; Determines either C02 or O2 rate from list of binary numbers
;; Usage:
;;   O2:  (det-rate ls > 1 0 len)
;;   C02: (det-rate ls < 0 0 len)
(define (det-rate ls proc default i len)
  (match (length ls)
    [1 (car ls)]
    [_ (if (= i len) (car ls)
     (let ([common (common-value ls i 0 0 proc default)])
         (det-rate (filter (λ (b) (= common (get-bit b i))) ls)
                   proc default (add1 i) len)))]))

(define (part-two input)
  (let* ([sum (sum-binary-list input)]
         [o2 (parse-binary (binary-bits (det-rate input > 1 0 (length input))))]
         [co2 (parse-binary (binary-bits (det-rate input < 0 0 (length input))))])
    (binary->number (binary-mult o2 co2))))
