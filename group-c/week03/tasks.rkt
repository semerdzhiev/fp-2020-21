#lang racket
; L: () - може да е празен списък
; L: {x, L1} - наредена двойка от първи елемент и опашка (която също е списък)

; cons
; pair? list?
; '(1 2 ... n): NB!!!: ` != '
; car (Content of the Address Register), cdr (Content of the Decrement Register)
; null, empty?
; =, eq?, eqv?, equal?
; length, reverse, append, member (memv / memq)
; map, filter, foldl (обхожда елементи отдясно-наляво) / foldr (обхожда елементи отляво-надясно)

; Задача 0: Да се дефинира функция (solve-quadratic a b c), която връща като резултат решенията на квадратното уравнение ax^2 + bx + c = 0
(define (solve-quadratic a b c)
  (define D (- (* b b) (* 4 (* a c))))
  (define x1 (/ (+ (- b) (sqrt D)) (* 2 a)))
  (define x2 (/ (- (- b) (sqrt D)) (* 2 a)))
  (
   if (< D 0)
      null
      (
       if (= D 0)
          (list x1)
          (list x1 x2)
       )
   )
  )

; Задача 1: Да се дефинира функция (mid p1 p2), която намира средата на отсечката P1P2 (p1, p2 - точки в равнина)
(define (mid p1 p2)
  (
   cons
       (/ (+ (car p1) (car p2)) 2)
       (/ (+ (cdr p1) (cdr p2)) 2)
   )
)

; Задача 2: Да се дефинира функция (my-length l), която връща дължината на списъка l
(define (my-length l)
  (if (empty? l)
      0
      (+ 1 (my-length (cdr l)))
  )
 )

; With fold
(define (my-length-2 l)
  (foldl (lambda (x y) (+ y 1)) 0 l)
)

; Задача 3: Да се дефинира функция (my-reverse l), която връща списъка, съдържащ елементите на l с обърната последователност
(define (my-reverse l)
  (
   if (empty? l)
      null
      (append (my-reverse (cdr l)) (car l))
   )
)

; With fold
(define (my-reverse-2 l)
  (
   foldl (lambda (x y) (cons x y)) null l
   )
)

; Задача 4: Да се дефинира функция (my-map f l), която връща списък с елементи y = f(x) при x - елементи на l
(define (my-map f l)
  (
   if (empty? l)
      null
      (cons (f (car l)) (my-map f (cdr l)))
  )
)

(define (my-map-2 f l)
  (
   foldr (lambda (x y) (cons (f x) y)) null l
  )
)

; Задача 5: Да се дефинира функция (take-elem l n), която връща n-тия елемент на списъка l ((take-elem l 1) <=> (car l))
(define (take-elem l n)
  (
   if (empty? l)
      #f
      (
       if (= n 1)
          (car l)
          (take-elem (cdr l) (- n 1))
       )
  )
)

; Задача 6: Да се дефинира функция (quick-sort l), която имплементира алгоритъма quicksort
(define (quick-sort l)
  (
     if (empty? l)
        null
        (let*
            (
              (pivot (car l))
              (rest (cdr l))
              (smaller (lambda (x) (< x pivot)))
              (bigger (lambda (x) (>= x pivot)))
            )
            (append (quick-sort (filter smaller rest)) (cons (car l) (quick-sort (filter bigger rest))))
        )
   )
)
