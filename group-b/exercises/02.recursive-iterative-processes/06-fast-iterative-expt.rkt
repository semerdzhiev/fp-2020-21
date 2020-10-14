#lang racket
(require rackunit)
(require rackunit/text-ui)

; Стъпвайки на дефиницията за бързо повдигане на степен,
; търсим такава, която генерира итеративен процес
(define (expt x n)
  (void)
)

(define tests
  (test-suite "expt tests"
    (check-equal? (expt 4 4) 256)
    (check-equal? (expt 29139123 0) 1)
    (check-equal? (expt 3 4) 81)
    (check-equal? (expt 2 1) 2)
  )
)

(run-tests tests 'verbose)
