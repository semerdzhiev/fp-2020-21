#lang racket
(require rackunit)
(require rackunit/text-ui)

; Функцията sum, която видяхме на упражнение.
; Да стане по итеративен начин.

(define (sum start end term next)
  (void)
)

(define (id x) x)
(define (inc x) (+ x 1))

(define tests
  (test-suite "Iterative sum tests"

    (check-equal? (sum 1 100 id inc) 5050)
    (check-equal? (sum 9 9 id inc) 9)
  )
)

(run-tests tests 'verbose)
