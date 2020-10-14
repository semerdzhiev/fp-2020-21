#lang racket
(require rackunit)
(require rackunit/text-ui)

; Функцията accumulate, която видяхме на упражнение.
; Да стане по итеративен начин.

(define (accumulate operation null-value start end term next)
  (void)
)

(define (id x) x)
(define (inc x) (+ x 1))

(define tests
  (test-suite "Iterative accumulate tests"

    (check-equal? (accumulate + 0 1 100 id inc) 5050)
    (check-equal? (accumulate + 0 9 9 id inc) 9)
    (check-equal? (accumulate * 1 1 5 id inc) 120)
    (check-equal? (accumulate / 1 1 5 id inc) 15/8)
  )
)

(run-tests tests 'verbose)