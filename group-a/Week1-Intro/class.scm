#lang r5rs

(define (-- n)
  (- n 1))

(define (fact n)
  (if (= n 0)
      1
      (* n
         (fact (-- n)))))

(define (fib n)
  (cond
    ((= n 1) 1)
    ((= n 2) 1)
    (else    (+ (fib (-- n))
                (fib (- n 2))))))
