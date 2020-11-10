#lang racket

; take и drop не се държат така попринцип в racket,
; а при по-голямо n биха хвърлили грешка.
; В Haskell примерно се държат точно както са написани тук.

; 1. Връща списъка lst само с първите n елемента.
(define (take* xs n)
  (cond [(zero? n) '()]
        [(> n (length xs)) xs]
        [else (cons
                (car xs)
                (take* (cdr xs)
                      (- n 1)))]))

; 2. Връща списъка lst без първите n елемента.
(define (drop* xs n)
  (cond [(zero? n) xs]
        [(> n (length xs)) '()]
        [else (drop* (cdr xs) (- n 1))]))

; 3. Свива lst наляво с операцията op и начална стойност acc (акумулатор).
(define (foldl* op acc lst)
  (if (null? lst)
    acc
    (foldl* op
            (op acc (car lst))
            (cdr lst))))

; 4. Свива lst надясно с операцията op и начална стойност acc (акумулатор).
(define (foldr* op acc lst)
  (if (null? lst)
    acc
    (op (car lst)
        (foldr* op acc (cdr lst)))))

; 5. Намира дължина на списък. Реализирайте я чрез foldl или foldr.
(define (length** lst)
  (foldl* (lambda (x _) (+ x 1)) 0 lst))

; 6. Връща списък с елементите на lst, но в обратен ред.
;    Реализирайте я чрез foldl.
;    Hint: Спомнете си как cons-овете могат да се изпълнят в обратен.
;          (както като писахме append)
(define (flip binary-op)
  (lambda (x y) (binary-op y x)))

(define (reverse* lst)
  (foldl* (flip cons) '() lst))

; 7. Намира броя на елементите в дълбокия списък lst. Тоест lst може да има
;    произволни нива на вложеност.
;    Реализирайте я чрез foldl/foldr
(define (count-atoms lst)
  (cond [(null? lst) 0]
        [(not (pair? lst)) 1]
        [else (+ (count-atoms (car lst))
                 (count-atoms (cdr lst)))]))


; 8. transpose m
(define (transpose m) (apply map list m))

; Разписваме transpose:
;
; (define m '((1 2 3)
;             (4 5 6)
;            (7 8 9)))
;
; (apply map list '((1 2 3) (4 5 6) (7 8 9)))
; <=>
; (map list '(1 2 3) '(4 5 6) '(7 8 9))
; <=>
; (list (list 1 4 7)
;       (list 2 5 8)
;       (list 3 6 9))
;
; (transpose m)
