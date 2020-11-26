(define (nset-contains? set elem) 
  (= 1 (remainder (quotient set (expt 2 elem)) 2))
)

(define (nset-add set elem)
  (if (nset-contains? set elem)
      set ;elem is already in the set
      (+ set (expt 2 elem))
  )
)

(define (nset-remove set elem)    
    (if (nset-contains? set elem)
        (- set (expt 2 elem))
        set ;elem is not in the set
  )
)

(define (nset-size set)
  (cond ((= set 0) 0)
        ((= 0 (remainder set 2)) (nset-size (quotient set 2)))
        (else (+ 1 (nset-size (quotient set 2))))
  )
)

(define (nset-contains-its-size s)
  (nset-contains? s (nset-size s))
)

(define (nset-map s f)
  (define (loop i r result)
    (cond ((= r 0) ; no more elements
           result)

          ((= 0 (remainder r 2)) ; i is not contained in the original set
           (loop (+ i 1) (quotient r 2) result))

          (else ; add f(i) to the result
           (loop (+ i 1) (quotient r 2) (nset-add result (f i))))
     )
  )
  (loop 0 s 0)
)
