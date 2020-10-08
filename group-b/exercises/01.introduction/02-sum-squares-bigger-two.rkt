#lang racket
(require "helpers.rkt")
(require rackunit)
(require rackunit/text-ui)
;1.3 - Съчинете процедура, която по дадени три числа, намира сумата от квадратите на по-големите две от тях.
; За по-удобно, може да разбиете задачата на по-малки такива.

(define (squares-sum-bigger-two a b c)
  (void)
)

(define tests
  (test-suite
    "Sum of squares tests"

    (let ((a (random 10))
          (b (random 10))
          (c (random 10)))
      
    (check-true (all-equal? (map (lambda (args) (apply squares-sum-bigger-two args))
                                (permute (list a b c)))))
)))

(run-tests tests 'verbose)
