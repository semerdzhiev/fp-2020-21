#lang racket/base
(require rackunit rackunit/gui racket/include)

(include "1.rkt")

(test/gui

 (test-suite
  "revlex-less?"
  (test-true  "0 is before 5"          (revlex-less? 0 5))
  (test-true  "1001 is before 991"     (revlex-less? 1001 991))
  (test-true  "91 is before 5"         (revlex-less? 91 5))
  (test-true  "23 is before 123"       (revlex-less? 23 123))
  (test-true  "13 is before 23"        (revlex-less? 13 23))
  (test-false "23 is NOT before 23"    (revlex-less? 23 23))
  (test-false "23 is NOT before 13"    (revlex-less? 23 13))
  (test-false "123 is NOT before 23"   (revlex-less? 123 23))
  (test-false "5 is NOT before 91"     (revlex-less? 5 91))
  (test-false "991 is NOT before 1001" (revlex-less? 991 1001))  
  (test-false "0 is NOT before 0"      (revlex-less? 0 0))
 )

  
 (test-suite
  "nset-accumulate"
  (test-eqv? "subtraction on {1,2,5} with init 10" (nset-accumulate - (lambda(x) x) 10 #b100110) 2)
  (test-eqv? "subtraction on {} with init 10"      (nset-accumulate - (lambda(x) x) 10 0) 10)
 )

 (test-suite
  "nset-revlex-min"
  (test-eqv? "revlex-min of {0, 5, 11} is 0"   (nset-revlex-min #b100000100001) 0)
  (test-eqv? "revlex-min of {5, 11} is 11"     (nset-revlex-min #b100000100000) 11)
  (test-false "(nset-revlex-min 0) returns #f" (nset-revlex-min 0))
 )
 
)