#lang racket/base
(require rackunit rackunit/gui racket/include)

(include "2.rkt")

(define set:empty     #b0)     ; 0
(define set:<1.3.4>   #b11010) ; 26
(define set:<0>       #b1)     ; 1
(define set:<1>       #b10)    ; 2
(define set:<0.1.3.4> #b11011) ; 27

(test/gui

 (test-suite
  "nset-contains?"
  
  (test-case
   "The empty set contains no elements"
   (check-false (nset-contains? set:empty 0))
   )

  (test-case
   "The elements of {1} are identified correctly"
   (check-true  (nset-contains? set:<0> 0))
   (check-false (nset-contains? set:<0> 1))
   )
 
  (test-case
   "The elements of the set {1, 3, 4} are identified correctly"
   (check-false (nset-contains? set:<1.3.4> 0))
   (check-true  (nset-contains? set:<1.3.4> 1))
   (check-false (nset-contains? set:<1.3.4> 2))
   (check-true  (nset-contains? set:<1.3.4> 3))
   (check-true  (nset-contains? set:<1.3.4> 4))
   (check-false (nset-contains? set:<1.3.4> 5))
   )
 )

 (test-suite
  "nset-add"

  (test-case
   "Elements are added correctly"
   (check-eqv? (nset-add set:empty   0) set:<0>)
   (check-eqv? (nset-add set:empty   1) set:<1>)
   (check-eqv? (nset-add set:<1.3.4> 0) set:<0.1.3.4>)
  )
 )

 (test-suite
  "nset-remove"

  (test-case
   "Elements are removed correctly"
   (check-eqv? (nset-remove set:<0> 0) set:empty)
   (check-eqv? (nset-remove set:<1> 1) set:empty)
   (check-eqv? (nset-remove set:<1.3.4> 0) set:<1.3.4>)
   (check-eqv? (nset-remove set:<0.1.3.4> 0) set:<1.3.4>)
  )
 )
 
 (test-suite
  "nset-contains-its-size"

  (test-true "{1,4,5,6} contains its size"              (nset-contains-its-size #b1110010))
  (test-false "{1,3,5,6} DOES NOT contain its size"     (nset-contains-its-size #b1101010))
  (test-false "The empty set DOES NOT contain its size" (nset-contains-its-size 0))
 )

 (test-suite
  "nset-map"
  (test-eqv? "mapping f(x)=2 returns {2}"    (nset-map #b101010 (lambda (x) 2))       #b100)
  (test-eqv? "id map does not alter the set" (nset-map #b101010 (lambda (x) x))       #b101010)
  (test-eqv? "1+ is mapped correctly"        (nset-map #b101010 (lambda (x) (+ x 1))) #b1010100)
  (test-eqv? "mapping over an empty set"     (nset-map 0 (lambda (x) (+ x 1)))        0)
 )
)