#lang racket
(require rackunit)
(require rackunit/text-ui)

; Искаме да вземем главния диагонал на матрица
(define (diagonal matrix)
  (void)
)

(define tests
  (test-suite "Diagonal tests"

    (test-case "" (check-equal? (diagonal '()) '()))
    (test-case "" (check-equal? (diagonal '((1 2 3) (4 5 6) (7 8 9))) '(1 5 9)))
  )
)

(run-tests tests 'verbose)
