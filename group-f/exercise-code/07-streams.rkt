#lang racket

(define (nats-after n)
  (stream-cons n (nats-after (+ 1 n))))


(define (nats-between a b)
  (if (> a b)
      (stream)
      (stream-cons a (nats-between (+ 1 a) b))))

(define nats (nats-after 0))


(define (take n l)
  (if (<= n 0)
      (list)
      (if (stream-empty? l)
          (list)
          (cons (stream-first l) (take (- n 1) (stream-rest l))))))


(define (wholes-after n)
  (stream-cons n (stream-cons (- 0 n) (wholes-after (+ n 1)))))

(define wholes (stream-rest (wholes-after 0)))

(define (stream-map f s)
  (if (stream-empty? s)
      s
      (stream-cons (stream-first s) (stream-map f (stream-rest s)))))

(define (stream-filter p s)
  (if (stream-empty? s)
      s
      (if (p (stream-first s))
          (stream-cons (stream-first s) (stream-filter p (stream-rest s)))
          (stream-filter p (stream-rest s)))))

(define (any p l)
  (if (null? l)
      #f
      (if (p (car l))
          #t
          (any p (cdr l)))))

(define (prime? n)
  (not (any (lambda (x) (= (remainder n x) 0)) (take (- n 2) (nats-after 2)))))

(define primes (stream-filter prime? nats))