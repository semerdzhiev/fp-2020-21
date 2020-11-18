#lang racket
(define (tree? t)
  (or (null? t)
      (and (list? t)
           (= (length t) 3))
           (tree? (cadr t))
           (tree? (caddr t))))
(define empty-tree '())
(define (make-tree root left right) (list root left right))
(define (make-leaf root) (make-tree root empty-tree empty-tree))
(define root-tree car)
(define left-tree cadr)
(define right-tree caddr)
(define empty-tree? null?)

(define example (make-tree 1
                           (make-tree 3 (make-leaf 8) empty-tree)
                           (make-tree 7 empty-tree (make-tree 9
                                                              (make-leaf 10)
                                                              (make-leaf 11)))))

(define example-bst (make-tree 8
                               (make-tree 3 (make-leaf 1) (make-tree 6 (make-leaf 4) (make-leaf 7)))
                               (make-tree 10 empty-tree (make-tree 14 (make-leaf 13) empty-tree))))

; искаме да проверим дали нещо се среща в дърво
(define (member-tree? x tree)
  (void)
)

; искаме да намерим сумата на всички елементи в дървото
(define (sum-tree tree)
  (void)
)

; искаме да намерим всички елементи на дадено ниво в дървото
(define (tree-level n tree)
  (void)
)


; искаме да приложим функцията f върху всички елементи на дървото (като истинската map, ама за дървета)
(define (tree-map f tree)
  (void)
)

; искаме да върнем списък от елементите на дървото
(define (tree->list tree)
  (void)
)


; искаме да вкараме елемент в двоично наредено дърво (binary search tree - BST)
(define (bst-insert x tree)
  (void)
)

(define (bst-member? x tree)
  (void)
)

(define example-list '(1 5 4 6 2 8 7))

; искаме да сортираме даден списък, използвайки tree->list и bst-insert
(define (sort xs)
  (void)
)

