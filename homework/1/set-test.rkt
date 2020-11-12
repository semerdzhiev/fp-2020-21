#lang racket/base
 
(require rackunit rackunit/gui racket/include)

(include "set.rkt")

(define set:empty       #b0)     ; 0
(define set:<1.3.4>     #b11010) ; 26
(define set:<0>         #b1)     ; 1
(define set:<1>         #b10)    ; 2
(define set:<0.1.3.4>   #b11011) ; 27
(define set:<0.2>       #b101)   ; 5
(define set:<0.1.2.3.4> #b11111) ; 31

(test/gui

 (test-suite
  "set-empty?"
  (test-true  "0 should be recognized as empty" (set-empty? set:empty))
  (test-false "non-negative numbers represent non-empty sets" (set-empty? set:<0>))
 )

 (test-suite
  "set-size"
  (test-eqv? "The empty set has size 0" (set-size set:empty) 0)
  (test-eqv? "{1,3,4} has size 3" (set-size set:<1.3.4>) 3)
  (test-eqv? "{0} has size 1" (set-size set:<0>) 1)
 )

 (test-suite
  "set-contains?"

  (test-case
   "The empty set contains no elements"
   (check-false (set-contains? set:empty 0))
  )

  (test-case
   "The elements of {1} are identified correctly"
   (check-true  (set-contains? set:<0> 0))
   (check-false (set-contains? set:<0> 1))
   )
 
  (test-case
   "The elements of the set {1, 3, 4} are identified correctly"
   (check-false (set-contains? set:<1.3.4> 0))
   (check-true  (set-contains? set:<1.3.4> 1))
   (check-false (set-contains? set:<1.3.4> 2))
   (check-true  (set-contains? set:<1.3.4> 3))
   (check-true  (set-contains? set:<1.3.4> 4))
   (check-false (set-contains? set:<1.3.4> 5))
   )
 )

 (test-suite
  "set-add"
  (test-case
   "Elements are added correctly"
   (check-eqv? (set-add set:empty   0) set:<0>)
   (check-eqv? (set-add set:empty   1) set:<1>)
   (check-eqv? (set-add set:<1.3.4> 0) set:<0.1.3.4>)
   )
 )

 (test-suite
  "set-remove"

  (test-case
   "Non-existing elements do not alter the set"
   (check-eqv? (set-remove set:<0> 1) set:<0>)
  )
  
  (test-case
   "Elements are removed correctly"
   (check-eqv? (set-remove set:<0>   0)     set:empty)
   (check-eqv? (set-remove set:<1>   1)     set:empty)
   (check-eqv? (set-remove set:<0.1.3.4> 0) set:<1.3.4>)
   )
 )
 

 (test-suite
  "set-union"
  
  (test-case
   "union with an empty set does not alter the original"
   (check-eqv? (set-union set:empty   set:empty)   set:empty)
   (check-eqv? (set-union set:<1.3.4> set:empty)   set:<1.3.4>)
   (check-eqv? (set-union set:empty   set:<1.3.4>) set:<1.3.4>)
   )

  (test-case
   "unions are calculated correctly"
   (check-eqv? (set-union set:<1.3.4> set:<0>) set:<0.1.3.4>)
   )
 )

 (test-suite
  "set-intersect"

  (test-case
   "intersection with an empty set returns the empty set"
   (check-eqv? (set-intersect set:empty   set:empty)   set:empty)
   (check-eqv? (set-intersect set:<1.3.4> set:empty)   set:empty)
   (check-eqv? (set-intersect set:empty   set:<1.3.4>) set:empty)
   )

  (test-case
   "intersections are calculated correctly"
   (check-eqv? (set-intersect set:<1.3.4>   set:<0>)     set:empty)
   (check-eqv? (set-intersect set:<0.1.3.4> set:<1.3.4>) set:<1.3.4>)
  )
 )

 (test-suite
  "set-difference"
  
  (test-case
   "difference with an empty set does not alter the original"
   (check-eqv? (set-difference set:empty   set:empty) set:empty)
   (check-eqv? (set-difference set:<1.3.4> set:empty) set:<1.3.4>)
  )

  (test-case
   "differences are calculated correctly"
   (check-eqv? (set-difference set:empty     set:<1.3.4>) set:empty)
   (check-eqv? (set-difference set:<1.3.4>   set:<0>)     set:<1.3.4>)
   (check-eqv? (set-difference set:<0.1.3.4> set:<1.3.4>) set:<0>)
  )
 )

 (test-suite
  "set-sum"
  (test-eqv? "Sum on an empty set returns 0"        (set-sum set:empty     (lambda (x) 1)) 0)
  (test-eqv? "sum on {0,1,3,4} with λx.1 returns 4" (set-sum set:<0.1.3.4> (lambda (x) 1)) 4)
  (test-eqv? "sum on {0,1,3,4} with λx.x returns 8" (set-sum set:<0.1.3.4> (lambda (x) x)) 8)
 )

 (test-suite
  "knapsack"

  (test-case
   "no solution"
   (let (
         (w (lambda (i)
             (case i
               ((0) 10)
               ((1) 10)
               ((2) 10))))
         (p (lambda (i) i))
        )
     (check-eqv? (knapsack 9 3 w p)   set:empty)
     (check-eqv? (knapsack 100 0 w p) set:empty)
    )
  )

  (test-case
   "solution exists"
   (let (
         (w (lambda (i)
             (case i
               ((0) 1)
               ((1) 5)
               ((2) 2)
               ((3) 1)
               ((4) 1))))
         (p (lambda (i)
             (case i
               ((0) 10)
               ((1) 5)
               ((2) 20)
               ((3) 1)
               ((4) 1))))
        )
     (check-eqv? (knapsack 3 5 w p)   set:<0.2>)
     (check-eqv? (knapsack 100 5 w p) set:<0.1.2.3.4>)
    )
  )
 )
)
   
