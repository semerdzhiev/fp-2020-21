#lang racket

(define (1+ x)
  (begin (display x)
         (+ 1 x))
  )

(define (square x) (* x x))

(square (1+ 4))
(square 5)
