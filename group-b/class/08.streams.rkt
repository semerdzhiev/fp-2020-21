#lang racket

(define-syntax my-delay
  (syntax-rules () ((my-delay expr) (lambda () expr))))

(define (my-force p) (p))

(define-syntax stream-cons
  (syntax-rules () ((stream-cons x xs) (cons x (my-delay xs)))))


(define (ones) (stream-cons 1 (ones)))

(define (head s) (car s))
(define (tail s) (my-force (cdr s)))

; искаме поток от всички естествени числа
(define (naturals)
  (void)
)

; искаме да вземем n-тия елемент на поток
(define (nth s n)
  (void)
)

; първите n елемента на даден поток
(define (stream-take s n)
  (void)
)

; превръщаме поток в списък
(define (stream->list s)
  (void)
)

; филтрираме елементите на поток
(define (stream-filter p? s)
  (void)
)

; прилагаме функция върху всеки елемент на поток
(define (stream-map f s)
  (void)
)

; конкатенираме два потока
(define (stream-append s t)
  (void)
)

; пропускаме първите n елемента на даден поток
(define (stream-drop s n)
  (void)
)

; правим безкраен поток от вида (x f(x) f(f(x)) f(f(f(x))) ...)
(define (iterate f x)
  (void)
)

; правим поток от вида (nv op(nv, a1) op(op(nv, a1), a2) ...)
(define (scanl op nv stream)
  (void)
)

; поток от всички прости числа
(define (primes)
  (void)
)