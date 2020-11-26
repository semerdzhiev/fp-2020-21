(define (number-valid? n)
  (cond ((< n 10) #t)
        ((= (remainder n 100) 0) #f) ;two consecutive zeros
        (else (number-valid? (quotient n 10)))
  )
)

(define (set-add s elem)
  (let* ((mask (expt 2 elem))
         (rest (quotient s mask)))
    (if (= 1 (remainder rest 2)) ; elem is already in the set
        s
        (+ s mask))
  )
)

(define (valid->nset n)

  (define (find-where-next-number-begins n)
    (if (= (remainder n 10) 0)
        0
        (+ 1 (find-where-next-number-begins (quotient n 10)))
    )
  )

  (define (loop k result)
    (cond ((= k 0) ; no more digits in the number
           result)

          ((= 0 (remainder k 10)) ; curent digit is zero
           (loop (quotient k 10) result))

          (else ; current digit is non-zero
           (let* (
                  (i           (find-where-next-number-begins k))
                  (mask        (expt 10 i))
                  (next-number (remainder k mask))
                  (rest-of-k   (quotient k (* 10 mask)))
                  )
             (loop rest-of-k (set-add result next-number))
           )
          )
    )
  )
  
  (if (number-valid? n) (loop n 0) #f)
)
  

(define (accumulate op term init a next b)  
  (define (loop i)
      (if (<= i b)
          (op (term i) (loop (next i)) )
          init
  ))
  (loop a)
)

(define (make-nset a b pred?)
  (define (1+ n) (+ 1 n))
  (define (id i) i)
  (define (op i result)
    (if (pred? i)
        (+ (expt 2 i) result)
        result
    )
  )
  (accumulate op id 0 a 1+ b)
)