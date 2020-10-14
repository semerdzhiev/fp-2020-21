#lang racket
(require rackunit)
(require rackunit/text-ui)

; Търсим процедура, която проверява дали всички числа в интервал удовлетворяват
; някакъв едноместен предикат.

(define (all-interval? start end next predicate?)
  (void)
)

(define tests
  (test-suite "All interval tests"
    (check-true (all-interval? 2 9 (lambda (x) (+ x 2)) (lambda (x) (< x 10))))
    (check-true (all-interval? 3 13 (lambda (x) (+ x 2)) odd?))
    (check-false (all-interval? 3 11 (lambda (x) (+ x 2)) (lambda (x) (not (= (remainder x 3) 1)))))
  )
)

(run-tests tests 'verbose)
