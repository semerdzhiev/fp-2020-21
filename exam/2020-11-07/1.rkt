(define (revlex-less? a b)
  (cond ((= a 0) (> b 0))
        ((= b 0) #f)
        ((< (remainder a 10) (remainder b 10)) #t)
        ((> (remainder a 10) (remainder b 10)) #f)
        (else (revlex-less? (quotient a 10) (quotient b 10)))
  )
)

(define (nset-accumulate op term init s)
  (define (loop i rest result)
    (cond ( (= 0 rest) ; no more elements in the set
            result )

          ( (= 1 (remainder rest 2)) ; i belongs to the set => perform the operation
            (loop (+ i 1) (quotient rest 2) (op result (term i))) )

          ( else ; i DOES NOT belong to the set => do not perform the operation
            (loop (+ i 1) (quotient rest 2) result) )
    )
  )
  (loop 0 s init)
)

(define (nset-revlex-min s)

  (define (find-first-element s) ; find the first element of a non-empty set
    (define (loop i rest)
      (if (= 1 (remainder rest 2))
          i
          (loop (+ i 1) (quotient rest 2))
      )
    )
    (loop 0 s)
  )
  
  (define (id x) x)

  (define (op result i)
    (if (revlex-less? result i) result i)
  )

  (if (= s 0) #f (nset-accumulate op id (find-first-element s) s))
)