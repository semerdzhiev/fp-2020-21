#lang racket
(require rackunit)
(require rackunit/text-ui)


; Обръщаме число от двоична в десетична бройна система
(define (to-decimal number)
  (void)
)

(define tests
  (test-suite "to-decimal tests"
    (check-equal? (to-decimal 11001) 25)
    (check-equal? (to-decimal 1100011) 99)
  )
)

(run-tests tests 'verbose)
