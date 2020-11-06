#lang racket
(require rackunit)
(require rackunit/text-ui)

; remove-duplicates 
; премахва всички повтарящи се елементи от списъка

(define (remove-duplicates xs)
  (void)
)

(define tests
  (test-suite "remove-duplicates"
    (check-equal? (remove-duplicates '(1 1 2 2 1 3 3 2 3))  '(1 2 3))
    (check-equal? (remove-duplicates '(1 2 3))  '(1 2 3))
  )
)

(run-tests tests 'verbose)
