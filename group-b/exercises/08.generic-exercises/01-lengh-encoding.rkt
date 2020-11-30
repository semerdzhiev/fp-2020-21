#lang racket
(require rackunit)
(require rackunit/text-ui)

; Искаме да компресираме списък по следния начин:
; поредни повтарящи се елементи слагаме в двойка, чийто първи елемент
; е стойността на елемента от списъка, а втория - броя поредни срещания.
; например:
; (encode '(1 1 1 2 3 3 4 4 4 4 4 4 1 1 2)) -> '((1 . 3) (2 . 1) (3 . 2) (4 . 6) (1 . 2) (2 . 1))

(define (encode xs)
  (void)
)

(define tests
  (test-suite
   "encode"
   (test-case "empty list" (check-equal? (encode '()) '()))
   (test-case "example list" (check-equal? (encode '(1 1 1 2 3 3 4 4 4 4 4 4 1 1 2)) '((1 . 3) (2 . 1) (3 . 2) (4 . 6) (1 . 2) (2 . 1))))
 )
)

(run-tests tests 'verbose)
                        