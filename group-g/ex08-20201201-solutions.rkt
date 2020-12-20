#lang racket

; За зад.2 от Домашно №1
(define (div2 n) (quotient n 2))
(define (mod2 n) (remainder n 2))

(define set-empty? zero?)
(define set-empty 0)
(define (last-bit? s)
  (= (mod2 s) 1))

; Когато напишем две почти идентични функции,
; ги обединяваме и абстрахираме различното поведение
; в малки функцийки-аргументи
;(define (set-intersect s1 s2)
;  (if (or (set-empty? s1) (set-empty? s2))
;      set-empty
;      (+ (* 2 (set-intersect (div2 s1) (div2 s2)))
;         (if (and (last-bit? s1) (last-bit? s2))
;             1
;             0))))

;(define (set-union s1 s2)
;  (if (or (set-empty? s1) (set-empty? s2))
;      (+ s1 s2)
;      (+ (* 2 (set-intersect (div2 s1) (div2 s2)))
;         (if (or (last-bit? s1) (last-bit? s2))
;             1
;             0))))

(define (set-helper s1 s2 combine bits-op)
  (if (or (set-empty? s1) (set-empty? s2))
      (combine s1 s2)
      (+ (* 2 (set-intersect (div2 s1) (div2 s2)))
         (if (bits-op (last-bit? s1) (last-bit? s2))
             1
             0))))

(define (set-intersect s1 s2)
  (set-helper s1 s2
              (lambda (s1 s2) set-empty)
              (lambda (b1 b2) (and b1 b2))))

(define (set-union s1 s2)
  (set-helper s1 s2
              (lambda (s1 s2)
                (if (set-empty? s1) s2 s1))
              (lambda (b1 b2) (or b1 b2))))

; Сега да напишем трета подобна функция е много по-лесно
(define (set-difference s1 s2)
  (set-helper s1 s2
              (lambda (s1 s2)
                (if (set-empty? s1) set-empty s1))
              (lambda (b1 b2)
                (and b1 (not b2)))))

; Пример за нечетим код с непроследима логика:
;(if (neshto1)
;    res1
;    (if (neshto2)
;        res2
;        (if (neshto3)
;            blah
;            res3))
; Аналогичен, по-четим и по-лесен за редактиране/допълване код
(cond [(neshto1) res1]
      [(neshto2) res2]
      [(neshto3) blah]
      [else res3])

; Лоша практика: преизчисляване на една и съща функция
; с едни и същи аргументи
(if (better (knapsack args1) (knapsack arg2))
    (knapsack args1)
    (knapsack args2))

; Решение
(let [(res1 (knapsack args1))
      (res2 (knapsack args2))]
  (if (better res1 res2) res1 res2))

; Горното изглежда като императивен стил,
; но всъщност е аналогично на следното:
; създаваме анонимна функция и веднага я извикваме,
; фиксирайки аргументите ѝ на подадените изрази
((lambda (res1 res2)
   (if (better res1 res2) res1 res2))
 (knapsack args1)
 (knapsack args2))

; МНОГО лош пример за императивен стил
(define (foo x y z)
  (if (...)
      (neshtosi)) ; не може if без трети аргумент (!)
  (display ...)
  (foo ...)
  (display ...))

(define head car)
(define tail cdr)
(define (maximum lst)
  (foldr (lambda (el res)
           (max el res))
         (head lst)
         (tail lst)))

; Често искаме да използваме специална
; функция за сравнение
(define (maximum* comp lst)
  (foldr (lambda (el res)
           (if (comp el res)
               el
               res))
         (head lst)
         (tail lst)))

; Или просто да сравним елементите по признак
(define (maximumBy f lst)
  (foldr (lambda (el res)
           (if (> (f el) (f res))
               el
               res))
         (head lst)
         (tail lst)))

; Аналогично сравнение на две неща
(define (maxBy f a b)
  (if (> (f a) (f b)) a b))

; Най-елегантното решение на горния проблем
(maxBy get-price (knapsack args1) (knapsack args2))

(define empty-tree '())
(define (make-tree root left right) (list root left right))      ; не искаме просто (define make-tree list) - защо?
(define (make-leaf root) (make-tree root empty-tree empty-tree)) ; за удобство
(define root-tree car)
(define left-tree cadr)
(define right-tree caddr)
(define empty-tree? null?)

(define test-tree
  (make-tree 10
             (make-tree 7
                        (make-leaf 10)
                        (make-leaf 2))
             (make-tree 3
                        (make-tree 4
                                   (make-leaf 1)
                                   (make-leaf 2))
                        empty-tree)))

(define (tree->list t)
  (if (empty-tree? t) '()
      (append (tree->list (left-tree t))
              (list (root-tree t))
              (tree->list (right-tree t)))))
; Наивно решение
(define (get-min-value t)
  (apply min (tree->list t)))

; скелет на функция - не можем да я извикваме
; върху празно дърво, трябва да обработим отделно
; случаите за 0,1 или 2 наследника
(define (get-max-value t)
  (if (empty-tree? t)
      ???
      (max (root-tree t)
           (get-max-value (left-tree t)
           (get-max-value (right-tree t))))

; Зад.8, наивно решение
(define (avg t)
  (if (empty-tree? t)
      t
      (make-tree (/ (+ (get-max-value t) (get-min-value t)) 2)
                 (avg (left-tree t))
                 (avg (right-tree t)))))

; Зад.8, интелигентно решение с помощна функция,
; която връща допълнителна информация към
; трансформираното дърво. Също скелет на решение,
; трябва да работи аналогично на get-max-value
(define (avg* t)
  ; Инварианта: връща наредена тройка от
  ; трансформирано дърво и мин/макс стойности в t
  (define (helper t)
    (if ...
        ...
        (let* [(res1 (helper (left-tree t)))
               (res2 (helper (right-tree t)))
               (minLeft (cadr res1)) ; можем да разбием резултата от рек. извиквания на компоненти за удобство
               (maxRight (cadr res2))
               (min* (min (root-tree t)
                          minLeft
                          minRight))
               (max* (max (root-tree t)
                          (caddr res1)
                          (caddr res2)))]
          ; Важно е да върнем пълната информация, за да спазим
          ; инвариантата си (няма компилатор да я enforce-не)
          (list (make-tree (/ (+ min* max*) 2)
                           (car res1)
                           (car res2))
                min*
                max*))))
  (head (helper t)))