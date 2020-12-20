#lang racket

(define (id x) x)

(define (accumulate from to op term acc)
  (if (> from to)
    acc
    (accumulate (+ from 1)
                 to
                 op
                 term
                 (op acc (term from)))))

(define (meetTwice? f g a b)
  (define (p? x) (= (f x) (g x)))
  (define (op acc x)
    (if (p? x)
      (+ acc 1)
      acc))
  (<= 2
   (accumulate
     a
     b
     op
     id
     0)))

(meetTwice? (lambda (x) x) sqrt 0 5)
; 1
; число 12345
; дължина n = 5
; x = 0
; n - x = 5
; x = 2
; n - x = 3
; 12345
; 234
; 3
(define (reverse-num-acc n)
  (define (op acc x)
      (+ (* acc 10) (remainder (quotient n (expt 10 x)) 10)))
  (accumulate n
              (floor (log n 10))
              op
              id
              0))

; acc = 12345
; x = 0
; to = 5
(define (op acc x)
  (remainder (quotient acc 10) ; 1234
             (expt 10 (- (floor (log acc 10)) 1))))

; acc = 12345
; 1234 % 10^3
; 10^n
; n - 2 (дължината на acc - 2)
; 1234567
; 123456 % 10^5

(op 12345 2)

; Вложена дефиниция и пазим резултата по време на обръщането
; в допълнителна променлива

; log 10 n - пъти
(define (reverse-num n)
  (define (iter k m)
    (if (= k 0)
      m
      (iter (quotient k 10) (+ (* m 10) (remainder k 10)))))
  (iter n 0))

(reverse-num-acc 12345)

; k m
; 12345 0
; 1234 5
; 123 54
; 12 543
; ...
