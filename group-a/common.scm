#lang r5rs

(define (++ n)
  (+ n 1))

(define (-- n)
  (- n 1))

(define (divides? a b)
  (= 0 (modulo b a)))

(define (squre x)
  (* x x))

(define (% x y)
  (modulo x y))

(define (// x y)
  (quotient x y))


(define (id n) n)

(define (default) #t)
