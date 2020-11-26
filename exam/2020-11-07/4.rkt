(define (ascending? n)
  (cond ((< n 10) #t)
        ((<= (remainder n 10) (remainder (quotient n 10) 10)) #f)
        (else (ascending? (quotient n 10)))
  )
)

(define (nset-filter s pred?)
  (define (loop i t result)
    (cond ((= t 0) ; no more elements in the set
           result) 

          ((and (= 1 (remainder t 2)) (pred? i)) ; i is in the set and (pred? i) is true
           (loop (+ i 1) (quotient t 2) (+ result (expt 2 i))))

          (else
           (loop (+ i 1) (quotient t 2) result))
    )
  )

  (loop 0 s 0)
)

(define (nset-member? s elem)
  (< 0 (nset-filter s (lambda (x) (= x elem))))
)

(define (nset-intersect s1 s2)
  (nset-filter s1 (lambda (x) (nset-member? s2 x)))
)
