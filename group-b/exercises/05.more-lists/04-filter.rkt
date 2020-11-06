#lang racket
(require rackunit)
(require rackunit/text-ui)

; filter
; приема едноместен предикат и списък
; връща списък само с елементите на оригиналния, които изпълняват условието

(define (filter p? ys)
  (void)
)

(define tests
  (test-suite "filter"
    (check-equal? (filter even? '(1 2 3))  '(2))
    (check-equal? (filter (lambda (x) (> x 200)) '(1 2 3))  '())
    (check-equal? (filter (lambda (x) (or (= x 1) (= x 3))) '(1 2 3))  '(1 3))
  )
)

(run-tests tests 'verbose)
