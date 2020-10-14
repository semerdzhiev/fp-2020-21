#lang racket

; Пита се какви процеси (итеративен или рекурсивен) се случват при извикването на тези две процедури

(define (inc x) (+ x 1))
(define (dec x) (- x 1))

(define (first-add a b)
  (if (= a 0)
      b
      (inc (first-add (dec a) b))))

(define (second-add a b)
  (if (= a 0)
      b
      (second-add (dec a) (inc b))))
