#lang racket
; Задача 0: Да се дефинира функция (sum-divisors n a b), която връща като резултат сумата на числата в затворения интервал [a, b], които са делители на n
(define (div x y) (= (remainder x y) 0))
(define (sum-divisors n a b)
  (
   if (> a b)
      0
      (+ (sum-divisors n (+ a 1) b) (if (div n a) a 0))
  )
  )
; Задача 0*: Да се дефинира функция (sum-squares a b), която връща като резултат сумата от квадратите на числата в затворения интервал [a, b]
(define (sum-squares a b)
  (
   if (> a b)
      0
      (+ (* a a) (sum-squares (+ a 1) b))
   )
  )

; Задача 1*: Да се дефинира функция (apply f x), която връща като резултат функцията f приложена върху аргумента x
(define (apply f x)
  (f x)
 )
; Пример за използване на ф-я от по-висок ред
(define (square x) (* x x))
; (apply square 5) - прилага square на аргумент 5

; Задача 1: Да се дефинира функция (sum-mapped f a b), която връща като резултат сумата на резултата на изпълнението на функцията f върху числата в затворения интервал [a, b]
; [a, b] -> SUM(f(x)), x <- [a, b]
(define (sum-mapped f a b)
  (
   if (> a b)
      0
      (+ (f a) (sum-mapped f (+ a 1) b))
   )
  )
; Lambda функции: (lambda (arg1 arg2 ... argn) (<тяло на ф-ята>))
; (sum-mapped square 1 5) <=> (sum-mapped (lambda (x) (* x x)) 1 5)

; Задача 2: Да се дефинира функция, която връща като резултат произведението на всички четни числа в интервала [a, b]
; 1 начин: 
(define (product-mapped f a b)
  (
   if (> a b)
      1
      (* (f a) (product-mapped f (+ a 1) b))
   )
  )

(define (product-even a b)
  (product-mapped (lambda (x) (if (div x 2) x 1)) a b)
)

; 2 начин:
(define (operation-mapped f a b operation neutral)
  (
   if (> a b)
      neutral
      (operation (f a) (operation-mapped f (+ a 1) b operation neutral))
  )
)
(define (product-even-2 a b)
  (operation-mapped (lambda (x) (if (div x 2) x 1)) a b * 1)
)

; Задача 3: Да се дефинира функция, която връща като резултат броя на всички точни квадрати в интервала [a, b]
; floor(sqrt(x))^2 == x OR floor(sqrt(x)) == sqrt(x)
(define (num-squares a b)
  (operation-mapped
   (lambda (x) (if (= (floor (sqrt x)) (sqrt x)) 1 0))
   a b + 0)
 )
; Задача 4: Да се дефинира функция, която проверява дали съществува число в интервала [a, b], за което функцията f да връща #t
; NB: find-elem не е много описателно име ;(
; NB2!: or е специална форма, дефинираме си бинарна функкция (lambda (x y) (or x y)), която го замества
(define (find-elem f a b)
  (operation-mapped f a b (lambda (x y) (or x y)) #f)
)
; обща форма на функциите досега: (define (accumulate f a b op n))
; accumulate: извиква функция (f) върху множество от аргументи ([a, b]) и акумулира резултат посредством някаква операция (op) с неутрален елемент (n)

; *: Да се дефинира функция (bind f x), която връща като резултат функция, изпълнението на която е същото като изпълнението на (f x)
(define (bind f x) (lambda () (f x)))

; NB: f, g са функции с 1 аргумент
; Задача 5: Да се дефинира функция (compose f g), която връща като резултат композицията на функциите f и g
(define (compose f g) (lambda (x) (f (g x))))

; Задача 6: Да се дефинира функция (repeat f n), която връща като резултат функция, еквивалентна на прилагането на функцията f n-пъти
; (repeat f n) <=> f ( f ( f ( f ( ... ( f x ) ... ) ) => n пъти
(define (id x) x)

(define (repeat f n)
  (
   if (= n 0)
      id
      (lambda (x) (f ((repeat f (- n 1)) x)))
   )
)
