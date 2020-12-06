#lang racket
; delay - отлага оценяването на даден израз, връща promise
; force - форсира оценяването на отложен израз, оценява promise

(define (head stream) (car stream))
(define (tail stream) (force (cdr stream)))

; Задача 0: Дефинирайте функция (repeat i), която създава безкраен поток от елемента i
; списъци
; '(i, i, i, i, i, i, i, i, i...)
; L :- '()
; L :- (x . L1)
; потоци:
; S :- '()
; S :- (x . <promise S1>)
(define (repeat i)
  (cons i (delay (repeat i)))
)

; Пример
(define stream-one (repeat 1))

; Задача 1: Дефинирайте функция (stream-take s n), която взима първите n елемента на потока s
; Ако s е с дължина по-малка от n, да се върнат колкото елементи има
(define (stream-take s n)
  (
   if (or (empty? s) (= n 0))
      '()
      (cons (head s) (stream-take (tail s) (- n 1)))
   )
)

; Задача 2: Дефинирайте функция (stream-drop s n), която връща поток без първите n елемента на s
; Ако s е с дължина по-малка от n, да се върне празен поток
(define (stream-drop s n)
  (
   cond
    [(empty? s) '()]
    [(= n 0) s]
    [else (stream-drop (tail s) (- n 1))]
   )
)

; Задача 3: Дефинирайте символ naturals-stream, който да съдържа
; безкраен поток от последователни естествени числа
; S :- '()
; S :- (x . <promise S1>)
; delay, force

(define (generate-naturals i)
  (cons i (delay (generate-naturals (+ i 1))))
)

(define naturals-stream
 (generate-naturals 1)
)

; Задача 4: Дефинирайте функция (generate init f), която генерира
; безкрайния поток init, f(init), f(f(init)) ...
(define (generate init f)
  (cons init (delay (generate (f init) f)))
)

; Задача 5: Дефинирайте функция (stream-map s f), която генерира поток от
; резултатите на функцията f приложена върху елементите на s
(define (stream-map s f)
  (
   if (empty? s)
      '()
      (cons (f (head s)) (delay (stream-map (tail s) f)))
   )
)

; Задача 6: Дефинирайте символ squares, който да съдържа
; безкраен поток от квадратите на всички естествени числа
(define natural-squares (stream-map naturals-stream (lambda (x) (* x x))))

; Задача 7: Дефинирайте функция (stream-filter s p), която генерира
; поток от елементите на s, за които (p x) връща истина
(define (stream-filter s p)
    (cond
      ((empty? s) '())
      ((p (head s)) (cons (head s) (delay (stream-filter (tail s) p))))
      (else (stream-filter (tail s) p))
    )
)

; Задача 8: Дефинирайте символ отговарящ на потока от естествени числа,
; които отговарят на условието (x^2 - 1) % 3 == 0
(define filtered-naturals (stream-filter naturals-stream (lambda (x) (= 0 (remainder (- (* x x) 1) 3)))))

; Задача 9: Дефинирайте функция (to-stream l), която превръща списъка l в поток
(define (to-stream l)
  (
   if (empty? l)
      '()
      (cons (car l) (delay (to-stream (cdr l))))
   )
)

; Задача 10: Дефинирайте функция (cycle l), която създава безкраен поток от непразния списък l
