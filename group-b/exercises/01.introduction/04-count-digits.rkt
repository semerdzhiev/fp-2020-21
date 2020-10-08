#lang racket
(require rackunit)
(require rackunit/text-ui)
; 1.5 - Търсим процедура, която намира броя цифри на дадено число
; Трябва да работи и за отрицателни числа.

(define (count-digits number)
  (void)
)

(define tests
  (test-suite
    "Count digits tests"

    (test-case "Should count correctly"
      (check-equal? (count-digits 1024) 4)
    )
    (test-case "Should work alright with negative numbers"
      (check-equal? (count-digits -987421245) 9)
    )
    (test-case "Should work alright with digits"
      (check-equal? (count-digits 9) 1)
      (check-equal? (count-digits 0) 1)
    )
  )
)


(run-tests tests 'verbose)
