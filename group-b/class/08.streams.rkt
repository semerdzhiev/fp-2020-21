#lang racket

(define a '(1 2 3))

; 1 -> 2 -> 3 -> '()
; 1 -> delayed
; head -> tail (който не се смята веднага)


(define-syntax my-delay
  (syntax-rules () ((my-delay expr) (lambda () expr))))


(define (my-force p) (p))

(define-syntax stream-cons
  (syntax-rules () ((stream-cons x xs) (cons x (my-delay xs)))))

; (stream-cons 1 '(2)) -> (cons 1 (my-delay '(2)))


(define (ones) (stream-cons 1 (ones)))

(define (head s) (car s))
(define (tail s) (my-force (cdr s)))
(define empty-stream '())
(define (stream-empty? s)
  (null? s))


; искаме поток от всички естествени числа
(define (naturals)
  (define (naturals-from x)
    (stream-cons x (naturals-from (+ x 1)))
  )
  (naturals-from 0) ; (0, ?????)
)

(define (compare-streams s1 s2)
  (cond ((and (stream-empty? s1) (stream-empty? s2)) #t)
        ((or (and (stream-empty? s1) (not (stream-empty? s2)))
             (and (stream-empty? s2) (not (stream-empty? s1)))) #f)
        ((equal? (head s1) (head s2)) (compare-streams (tail s1) (tail s2)))
        (else #f))
)

(define (stream-range s e)
  (if (> s e)
      empty-stream
      (stream-cons s (stream-range (+ s 1) e))))

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