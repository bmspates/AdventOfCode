#lang racket
(require "input.rkt" "utils.rkt" "line.rkt")
(provide main)

(define (parse-points ls)
  (match ls
    ['() '()]
    [(cons x ls) (if (string-contains? x ",")
                     (cons (make-point (string-split x ","))
                           (parse-points ls))
                     '())]))

(define (parse-folds ls)
  (match ls
    ['() '()]
    [(cons x ls) (if (string-contains? x ",") (parse-folds ls)
                     (let ((y (string-split x "=")))
                       (cons (cons (if (string-contains? (first y) "x")
                                       "x" "y") (string->number (second y)))
                             (parse-folds ls))))]))

(define (main)
  (let* ((input (strip-newlines (read-lines "inputs/day13.txt")))
         (points (list->set (parse-points input)))
         (folds (parse-folds input))
         (br (bottom-right (set->list points))))
    (values (fold-num points folds (add1 (point-x br)) (add1 (point-y br)) 1 num-points)
            (display (fold-num points folds (add1 (point-x br)) (add1 (point-y br)) (length folds)
                               (λ (p r c)
                                 (let ((b (box "")))
                                   (for ((row r))
                                     (for ((col c))
                                       (set-box!
                                        b
                                        (string-append
                                         (unbox b)
                                         (if (set-member? p (point row col)) "#" " "))))
                                     (set-box! b (string-append (unbox b) "\n")))
                                   (unbox b))))))))

(define (num-points points rows cols)
  (let ((b (box 0)))
    (for ((row rows))
      (for ((col cols))
        (when (set-member? points (point row col))
          (set-box! b (add1 (unbox b))))))
    (unbox b)))

(define (fold-num points folds rows cols num-folds proc)
  (if (= num-folds 0)
      (proc points rows cols)
      (let ((f (first folds)))
        (match (car f)
          ["x" (fold-num (set-union (set-filter (λ (p) (< (point-x p) (cdr f))) points)
                                    (list->set (set-map (set-filter (λ (p) (>= (point-x p) (cdr f))) points)
                                                        (λ (p) (point (- (cdr f) (abs (- (cdr f) (point-x p))))
                                                                      (point-y p))))))
                         (rest folds) (- rows (cdr f)) cols (sub1 num-folds) proc)]
          ["y" (fold-num (set-union (set-filter (λ (p) (< (point-y p) (cdr f))) points)
                                    (list->set (set-map (set-filter (λ (p) (>= (point-y p) (cdr f))) points)
                                                        (λ (p) (point (point-x p)
                                                                      (- (cdr f) (abs (- (cdr f) (point-y p)))))))))
                         (rest folds) rows (- cols (cdr f)) (sub1 num-folds) proc)]))))