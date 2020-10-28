#lang racket
(require rackunit)
(require rackunit/text-ui)

; Търсим функция, която обръща даден списък
(define (reverse xs)
  (void)
)

; И нейн итеративен вариант
(define (reverse-iter xs)
  (void)
)

(define tests
  (test-suite "Reverse tests"
      (check-equal? (reverse-iter '(1 2 3)) (reverse '(1 2 3)))
      (check-equal? (reverse '()) '())
      (check-equal? (reverse '(1)) '(1))
      (check-equal? (reverse '(1 5)) '(5 1))
  )
)

(run-tests tests 'verbose)