#lang racket

(define print-x-once-return-3 (delay (begin (display "x\n")
                                            3
                                            )))


(define (fib n)
  (case n
     ((1 2) 1)
     (else (+ (fib (- n 1))
              (fib (- n 2))
              ))
    )
  )


(define fib42 (delay (fib 42)))

(define-syntax cons-stream
  (syntax-rules ()
    ((cons-stream h t) (cons h (delay t)))
    )
  )

(define head car)

(define (tail strm) (force (cdr strm)))


(define n-fibn (cons-stream 7 (begin
                                (display "lalaLand\n")
                                (fib 7))))


(define-syntax do
  (syntax-rules (=)
    ([do (a = b)] (set! a b))
    ([do (a = b) exprs ...] (begin (do (a = b))
                                   (do exprs ...)
                                   ))

    ([do expr] expr)
    )
  )

(define x 6)

(do (x = (fib x))
    (x = (fib x))
    ;; (* x x)
    )

(define ones (stream-cons 1 ones))

(define (nats-from n)
  (stream-cons n (nats-from (+ n 1)))
  )

(define nats (nats-from 1))

(define 1-2-3 (stream-cons 1 (stream-cons 2 (stream-cons 3 empty-stream))))
