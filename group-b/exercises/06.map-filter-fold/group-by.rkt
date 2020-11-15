#lang racket
(require rackunit)
(require rackunit/text-ui)

; group-by
; разбива списъка xs спрямо функцията f
; например:
; (group-by even? '(1 2 3 4 5)) -> ((#f (1 3 5))
;                                   (#t (2 4)))
;(group-by length '((1 2 3) (4) (5 6 7))) -> '((1 ((4)))
;                                              (3 ((1 2 3) (5 6 7))))

; идеално би било това да стане без рекурсия

(define (group-by f xs)
  (void)
)

(define tests
  (test-suite "group-by"
    (check-equal? (assq #f (group-by even? '(1 2 3 4 5))) '(#f 1 3 5))
    (check-equal? (assq 3 (group-by length '((1 2 3) (4) (5 6 7))))
		  '(3 (1 2 3) (5 6 7)))
  )
)

(run-tests tests 'verbose)
