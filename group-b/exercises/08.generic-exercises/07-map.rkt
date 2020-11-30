#lang racket
(require rackunit)
(require rackunit/text-ui)

; Искаме да направим map, но за списък с произволно ниво на влагане

(define (deep-map f xs)
  (void)
)


(define tests
  (test-suite "deep map tests"
    
    (test-case "" (deep-map (lambda (x) (* x 5)) '(1 2 (3 (4 5) 6) 7 8)) '(5 10 (15 (20 25) 30) 35 40))
  )
)

(run-tests tests 'verbose)