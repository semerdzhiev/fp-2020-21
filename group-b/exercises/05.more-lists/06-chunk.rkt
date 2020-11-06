#lang racket
(require rackunit)
(require rackunit/text-ui)

; chunk 
; разбива списъка xs на подсписъци с дължина n

(define (chunk n xs)
  (void)
)

(define tests
  (test-suite "chunk"
    (check-equal? (chunk 2 '(1 2 3 4 5 6 7 8 9))  '((1 2) (3 4) (5 6) (7 8) (9)))
    (check-equal? (chunk 3 '(1 2 3 4 5 6 7 8 9))  '((1 2 3) (4 5 6) (7 8 9)))
  )
)

(run-tests tests 'verbose)
