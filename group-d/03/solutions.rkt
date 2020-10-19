#lang racket

; Идентитета не е част от R5RS, може да ви потрябва :)
(define (id x) x)

; * Вече писахме функция, която намира сумата на числа в
; интервал.
; 1. Намира сумата на израз от числата в даден интервал
; - term(x), за всяко x от интервала при сумиране
; Пример: сума на x^2, x/4, 2^x и т.н.
(define (sum-term from to term acc)
  (if (> from to)
    acc
    (sum-term (+ from 1)
                to
                term
                (+ acc (term from)))))

; 2. Напишете функция като горната,
; но натрупва резултата с произволна бинарна операция.
; Реализирайте я чрез итеративен процес.
; Пример: сума, произведение, дизюнкция и т.н.
(define (accumulate from to step term acc)
  (if (> from to)
    acc
    (accumulate (+ from 1)
                 to
                 step
                 term
                 (step acc (term from)))))

; 3. Реализирайте факториел чрез accumulate.
(define (fact n)
  (accumulate 1 n * id 1))

; 4. Намира броя на числата в интервал, които изпълняват даден предикат.
; Реализирайте я чрез accumulate.
(define (count-p from to p)
  (define (inc-if acc x)
      (if (p x) (+ acc 1) acc))
  (accumulate from to inc-if id 0))

; 5. Проверява дали даден предикат е верен за всички числа в даден интервал.
; Реализирайте я чрез accumulate.
(define (for-all? from to p)
  (define (and2 a b)
    (and a b))
  (accumulate from to and2 p #t))

; 6 .Тя проверява дали някое число в даден интервал изпълнява даден предикат.
; Реализирайте я чрез accumulate.
(define (exists? from to p)
  (define (or2 a b)
    (or a b))
  (accumulate from to or2 p #f))

; 7. За даден едноместен предикат p, връща отрицанието му.
; Не отрицанието на резултата, а нов предикат който е отрицание на p.
(define (complement p)
  (lambda (x) (not (p x))))

; 8. За дадена функция на два аргумента f,
; връща функцията над разменени аргументи.
(define (flip f)
  (lambda (x y) (f y x)))

; 9. Взима едноаргументна функция f и връща композицията (f∘f)
(define (double f)
  (lambda (x) (f (f x))))

; 10. За дадени едноаргументни функции f и g връща композицията им (f∘f)
(define (compose f g)
  (lambda (x) (f (g x))))

; 11. За дадена едноаргументна функция f и число n,
; връща n-тото прилагане на f. Тоест f^n.
; Пример: (repeat f 3) x) ще е същото като (f (f (f x)))
(define (repeat f n)
  (if (zero? n)
    id
    (lambda (x)
      (f ((repeat f (- n 1)) x)))))

