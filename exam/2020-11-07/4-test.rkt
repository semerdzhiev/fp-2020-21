#lang racket/base
(require rackunit rackunit/gui racket/include)

(include "4.rkt")

(test/gui
 (test-suite
  "ascending?"
  (test-true "0 is ascending" (ascending? 0))
  (test-true "1 is ascending" (ascending? 1))
  (test-true "123 is ascending" (ascending? 123))
  (test-true "1259 is ascending" (ascending? 1259))
  (test-false "91 is NOT ascending" (ascending? 91))
  (test-false "1223 is NOT ascending" (ascending? 1223))
 )  

 (test-suite
  "nset-filter"
  (let ((s:8-7-5-4-3-2 #b110111100))
    (test-eqv? "filter even numbers" (nset-filter s:8-7-5-4-3-2 even?) #b100010100)
    (test-eqv? "filter odd numbers"  (nset-filter s:8-7-5-4-3-2 odd?)  #b10101000)
    (test-eqv? "filter only 8"       (nset-filter s:8-7-5-4-3-2 (lambda (x) (= x 8))) #b100000000)
    (test-eqv? "filter 9 gives ∅"    (nset-filter s:8-7-5-4-3-2 (lambda (x) (= x 9))) 0)
    (test-eqv? "filter on ∅"         (nset-filter 0 (lambda (x) #t))                  0)
   )
 )   
 
 (test-suite
  "nset-intersect"

  (let (
        (s:6-5-3-2-1 #b1101110)
        (s:5-3-2-1 #b101110)
        (s:6-1-0  #b1000011)
        (s:empty 0)
        )

    (test-eqv?
     "{5,3,2,1}∩{6,1,0}={1,0}"
     (nset-intersect s:5-3-2-1 s:6-1-0)
     #b10)

    (test-eqv?
     "{6,5,3,2,1}∩{6,1,0}={6,1,0}"
     (nset-intersect s:6-5-3-2-1 s:6-1-0)
     #b1000010)     
 
    (test-eqv?
     "{6,5,3,2,1}∩∅=∅"
     (nset-intersect s:5-3-2-1 s:empty)
     0)

    (test-eqv?
     "∅∩{6,5,3,2,1}=∅"
     (nset-intersect s:empty s:5-3-2-1)
     0)

    (test-eqv?
     "∅∩∅=∅"
     (nset-intersect s:empty s:empty)
     0)
    )
  )
)