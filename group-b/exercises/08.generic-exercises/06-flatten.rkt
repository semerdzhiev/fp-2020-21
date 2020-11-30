#lang racket
(require rackunit)
(require rackunit/text-ui)

; Искаме да направим списък от всички стойности в даден такъв.
; Искаме нивата на влагане да изчезнат.

(define (flatten xs)
  (void)
)


(define tests
  (test-suite "flatten tests"
    
    (test-case "" (flatten '(1 2 (3 (4 5) 6) 7 8)) '(1 2 3 4 5 6 7 8))
  )
)

(run-tests tests 'verbose)