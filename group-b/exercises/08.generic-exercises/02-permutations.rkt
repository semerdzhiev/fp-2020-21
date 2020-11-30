#lang racket
(require rackunit)
(require rackunit/text-ui)

; Искаме да намерим всички пермутации на даден списък

(define (permutations xs)
  (void)
)

(define tests
  (test-suite
   "permutations"
   (test-case "empty list" (check-equal? (permutations '()) '()))
   (test-case "example list" (check-equal? (permutations '(1 2 3)) '((1 2 3) (1 3 2) (2 1 3) (2 3 1) (3 1 2) (3 2 1))))
 )
)

(run-tests tests 'verbose)
                        