#lang racket

; Полезни помощни функции
(define head car)
(define tail cdr)
; map,filter,foldr,any?,all?,drop,take,range,
; dropWhile,takeWhile,list-ref,zip,zipWith

(define (dropWhile p? lst)
  (cond [(null? lst) '()]
        [(p? (head lst)) (dropWhile p? (tail lst))]
        [else lst]))
; takeWhile е аналогична на take

; 1 2 3    '((1 2 3)
; 4 5 6 ->   (4 5 6)
; 7 8 9      (7 8 9))

(define m '((1 2 3 4 5 6)
            (2 3 4 5 8 9)
            (0 2 6 4 8 2)
            (5 2 8 4 9 0)))
; Зад.1
; (sub-matrix 1 2 3 5 ...) -> '((4 5 8) (6 4 8))
(define (sub-range i j lst)
  (drop (take lst j) i))

(define (sub-matrix i1 j1 i2 j2 m)
  (let [(the-rows (sub-range i1 i2 m))]
    (map (lambda (row) (sub-range j1 j2 row)) the-rows)))

; Зад.2
(define (foldr-matrix op-rows nv-rows op-elems nv-elems m)
  (foldr op-rows nv-rows
         (map (lambda (row) (foldr op-elems nv-elems row)) m)))

; Зад.3
; Упътване: да се имплементира функция, извършваща Гаусова елиминация:
; '(( 2  3  6)     '((2   3  6)
;   ( 1  0  5)  ->   (0 -3/2 2)
;   (-2  5 -4))      (0   8  2))

; Интерфейс (непълен) за работа с матрици, произлизащ от двупосочното им обхождане
(define (head-rows m) (head m))
(define (head-cols m) (map head m))
(define (tail-rows m) (tail m))
(define (tail-cols m) (map tail m))
(define (null-m? m) (or (null? m) (null? (head m))))

; Стандартна
(define (zipWith f lst1 lst2)
  (if (or (null? lst1) (null? lst2)) '()
      (cons (f (head lst1) (head lst2))
            (zipWith f (tail lst1) (tail lst2)))))
; Прибавя row1 към row2 с множител, нулиращ първия елемент на row2
(define (gauss-row row1 row2)
  (let [(coeff (- (/ (head row2) (head row1))))]
    (zipWith (lambda (x y) (+ (* x coeff) y)) row1 row2)))
; Гаусова елиминация (само по първи стълб)
(define (gauss-step m)
  (cons (head-rows m)
        (map (lambda (row) (gauss-row (head-rows m) row)) (tail-rows m))))

; Забележка: ако gauss-step не беше отделна функция, можеше да връща само всички редове без първия,
; дори да премахва и първия стълб. В такъв случай бихме си спестили и извикванията на tail-rows и tail-cols по-долу.
(define (determinant m)
  (if (null-m? m) 1
      (* (head (head-rows m))
         (determinant (tail-rows (tail-cols (gauss-step m)))))))

; Интерфейс за работа с дървета.
; Добре е да го използваме изцяло, без да разчитаме на
; имплементацията отдолу (!)
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

; Зад.4
(define (tree-sum t)
  (if (empty-tree? t) 0
      (+ (root-tree t)
         (tree-sum (left-tree t))
         (tree-sum (right-tree t)))))

; Зад.5
(define (tree-level k t)
  (cond [(empty-tree? t) '()] ; не забравяме дъното
        [(zero? k) (list (root-tree t))]
        [else (append (tree-level (- k 1) (left-tree t))
                      (tree-level (- k 1) (right-tree t)))]))

; Зад.6
; Това може да е самостоятелна задачка
(define (height t)
  (if (empty-tree? t) 0
      (+ 1 (max (height (left-tree t))
                (height (right-tree t))))))

(define (all-levels t)
  (map (lambda (i) (tree-level i t)) (range 0 (height t))))

; Алтернативно решение със сливане на списъците,
; получени то двете поддървета.
; Помощна функция, аналогична на zipWith
(define (merge-levels lst1 lst2)
  (cond [(null? lst1) lst2]
        [(null? lst2) lst1]
        [else (cons (append (head lst1) (head lst2))
                    (merge-levels (tail lst1) (tail lst2)))]))

(define (all-levels* t)
  (if (empty-tree? t) '()
      (cons (list (root-tree t))
            (merge-levels (all-levels* (left-tree t))
                          (all-levels* (right-tree t))))))

; Зад.7
(define (tree-map f t)
  (if (empty-tree? t) t ; забележете, ползваме интерфейса
      (make-tree (f (root-tree t))
                 (tree-map f (left-tree t))
                 (tree-map f (right-tree t)))))

; Зад.8
(define (tree->list t)
  (if (empty-tree? t) '()
      (append (tree->list (left-tree t))
              (list (root-tree t))
              (tree->list (right-tree t)))))
               





