#lang racket/base
(require rackunit rackunit/gui racket/include)

(include "3.rkt")

(test/gui
 (test-suite
  "numbre-valid?"
  (test-true "0 is valid" (number-valid? 0))
  (test-true "5 is valid" (number-valid? 5))
  (test-true "123 is valid" (number-valid? 123))
  (test-true "1230 is valid" (number-valid? 1230))
  (test-true "1023012301 is valid" (number-valid? 1023012301))
  (test-false "12003 is NOT valid" (number-valid? 12003))
  (test-false "120300 is NOT valid" (number-valid? 120300))
 )  
 
 (test-suite
  "valid->nset"
  (let ((s:12-11-5-1 #b1100000100010))
    (test-eqv? "50501205011010 -> {1,5,11,12}" (valid->nset 50501205011010) s:12-11-5-1)
    (test-eqv? "5050120501101 -> {1,5,11,12}"  (valid->nset 5050120501101) s:12-11-5-1)
    (test-eqv? "0 -> {}"                       (valid->nset 0) 0)
    (test-false "120034 -> #f"                 (valid->nset 120034))
    (test-false "12003400 -> #f"               (valid->nset 12003400))
  )
 )   

 (test-suite
  "make-nset"

  (let (
        (s:6-4-2 #b1010100)
        (s:5-3   #b101000)
        (s:5     #b100000)
        (s:empty 0)
        )

    (test-eqv?
     "even numbers in [2,6]"
     (make-nset 2 6 even?)
     s:6-4-2)

    (test-eqv?
     "odd numbers greater than 2 in [0,6]"
     (make-nset 0 6 (lambda (x) (and (> x 2) (odd? x))))
     s:5-3)
 
    (test-eqv?
     "equal to 5 in [0,6]"
     (make-nset 0 6 (lambda (x) (= x 5)))
     s:5)

    (test-eqv?
     "equal to 10 in [0,6]"
     (make-nset 0 6 (lambda (x) (= x 10)))
     s:empty)
  )
 )
)