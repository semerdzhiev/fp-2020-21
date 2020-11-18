#lang racket
; Задача 0: Да се дефинира функция (take n l), която връща първите n елемента на списъка l
(define (take n l)
  (
   if (or (empty? l) (= n 0))
      null
      (cons (car l) (take (- n 1) (cdr l)))
   )
)

; Задача 1: Да се дефинира функция (drop n l), която връща списък без първите n елемента на списъка l
(define (drop n l)
  (
   if (or (= n 0) (empty? l))
      l
      (drop (- n 1) (cdr l))
   )
)

; Задача 2: Да се дефинира функция (is-palindrome? l), която връща #t ако списъка l е палиндром и #f в противен случай
(define (is-palindrome? l) (equal? l (reverse l)))

; Задача 3: Да се дефинира функция (flatten ls), която приема списък от списъци ls и връща списък, съставен от елементите на списъците в ls
; '('(1 2 3) '(4 5 6) '(7 8 9)) => '(1 2 3 4 5 6 7 8 9)
; append, fold(l/r), map, filter ...
(define (flatten ls)
  (
   if (empty? ls)
      ls
      (append (car ls) (flatten (cdr ls)))
   )
)

; Задача 4: Да се дефинира функция (dot-product v1 v2), която връща като резултат скаларното произведение на векторите v1 и v2 (представени като списъци)
(define (dot-product v1 v2)
  (define (dp-helper v1 v2)
  (
   if (empty? v1)
      0
      (+ (* (car v1) (car v2)) (dp-helper (cdr v1) (cdr v2)))
   ))
  (
   if (= (length v1) (length v2))
      (dp-helper v1 v2)
      #f
   )
)

; Задача 5: Да се дефинира функция (sum-matrix m1 m2), която връща като резултат матрицата равна на сумата на матриците m1 и m2 (представени като списъци от списъци)
; Пример: (sum-matrix '((1 2) (3 4)) '((5 6) (7 8)) ) => '((6 8) (10 12))
; Начин 1:
(define (sum-vectors v1 v2)
  (
   if (or (empty? v1)
          (empty? v2))
      null
      (cons
       (+ (car v1) (car v2))
       (sum-vectors (cdr v1) (cdr v2))
       )
      )
  )
(define (sum-matrix m1 m2)
  (
   if (or
       (empty? m1)
       (empty? m2)
      )
      null
     (cons
        (sum-vectors (car m1) (car m2))
        (sum-matrix (cdr m1) (cdr m2))
      )
     )
  )

; Начин 2:
(define (sum-matrix-2 m1 m2)
  (map (lambda (r1 r2) (map (lambda (el1 el2) (+ el1 el2)) r1 r2)) m1 m2)
)

; Задача 5*: Да се дефинира функция (matrix-mult m1 m2), която връща като резултат произведението на матриците m1 и m2
; Задача 6: Да се дефинира функция (transpose-matrix m), която връща транспсонираната матрица на m
; Пример: '((1 2) (3 4)) => '((1 3) (2 4))
(define (transpose-matrix m)
  (
   if (empty? (car m))
      null
      (cons (map car m) (transpose-matrix (map cdr m)))
  )
)

