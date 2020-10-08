#lang racket
(require rackunit)
(require rackunit/text-ui)

;1.1 - Преведете следващите изрази в префиксна форма
; Попълвате на мястото на (void)
; a - ((2 + 3/16) / (9 * 2.78)) + ((5 / 2) - 6)
(define a (void))

; b - (15 + 21 + (3 / 15) + (7 - (2 * 2))) / 16
(define b (void))

; c - (5 + 1/4 + (2 - (3 - (6 + 1/5)))) / 3(6 - 2)(2 - 7)
(define c (void))

(define (square x) (* x x))

; d - (3^2 + 5) / (3^3 - 2)
(define d (void))

; e - (16^4 + 95/2)
(define e (void))

(define first-tests
  (test-suite
    "Translated expressions tests"

    (test-case "1.1-a"

      (check-equal? a -3.412569944044764))

    (test-case "1.1-b"
      (check-equal? b 49/20))

    (test-case "1.1-c"
      (check-equal? c -209/1200))

    (test-case "1.1-d"
      (check-equal? d 14/25))

    (test-case "1.1-e"
      (check-equal? e 131167/2))))

(run-tests first-tests 'verbose)
