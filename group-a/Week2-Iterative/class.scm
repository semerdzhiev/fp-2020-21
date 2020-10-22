#lang r5rs

(define (++ n)
  (+ n 1))

(define (-- n)
  (- n 1))

(define (fact n)
  (if (= n 0)
      1
      (* n
         (fact (-- n)))))

(define (fact-iter n)
  (define (loop i result)
    (if (> i n)
        result
        (loop (++ i)
              (* result i))))

  (loop 2 1))

(define (fib n)
  (define (n- x) (- n x))

  (case n
    ((1 2) 1)
    (else (+ (fib (n- 1))
             (fib (n- 2))))))

(define (fib-iter n)
  (define (loop i f-2 f-1)
    (if (> i n)
        f-1
        (loop (++ i)
              f-1
              (+ f-1 f-2))))

  (loop 3 1 1))
