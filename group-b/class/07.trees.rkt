#lang racket
; construction
(define empty-tree '())
(define (make-tree root left right) (list root left right))
(define (make-leaf root) (make-tree root empty-tree empty-tree))
;getters
(define root-tree car)
(define left-tree cadr)
(define right-tree caddr)
; validation
(define (tree? t)
  (or (null? t)
      (and (list? t)
           (= (length t) 3)
           (tree? (cadr t))
           (tree? (caddr t)))))
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
; във всяка от задачите започваме с проверка за празно дърво
; елемент се среща в дърво, тогава когато:
; - или е корена на дървото
; - или се среща в лявото, или дясното поддърво (среща се = member-tree?)
(define (member-tree? x tree)
  (cond ((empty-tree? tree) #f)
        ((equal? x (root-tree tree)) #t)
        (else (or (member-tree? x (left-tree tree)) (member-tree? x (right-tree tree)))))
)

; искаме да намерим сумата на всички елементи в дървото
(define (sum-tree tree)
  (cond ((empty-tree? tree) 0)
        (else (+ (root-tree tree) (sum-tree (left-tree tree)) (sum-tree (right-tree tree)))))
)

; искаме да намерим всички елементи на дадено ниво в дървото
; тук имахме две дъна:
; - отново гледаме за празно дърво
; - проверяваме дали сме поискали ниво 0 - тогава е окей да върнем корена на дървото ни (след като знаем, че не е празно)
; - иначе комбинираме (с append) резултатите за лявото и дясното поддърво, но с по-малко ниво
(define (tree-level n tree)
  (cond ((empty-tree? tree) '())
        ((= n 0) (list (root-tree tree)))
        (else (append (tree-level (- n 1) (left-tree tree)) (tree-level (- n 1) (right-tree tree)))))
)


; искаме да приложим функцията f върху всички елементи на дървото (като истинската map, ама за дървета)
(define (tree-map f tree)
  (if (empty-tree? tree) empty-tree
      (make-tree (f (root-tree tree))
              (tree-map f (left-tree tree))
              (tree-map f (right-tree tree)))
  )
)
; за сравнение долу има map за списъци
; приличат си по това, че имаме проверка за празна структура (дърво - empty-tree? или списък - null?).
; ако последната е непразна, конструираме структура (дърво - make-tree или списък - cons), като приложим функцията
; f върху текущия елемент

;(define (map f xs)
;  (if (null? xs)
;      '()
;      (cons (f (car xs)) (map f (cdr xs)))))


; искаме да върнем списък от елементите на дървото - ляво, корен, дясно
(define (tree->list tree)
  (cond ((null? tree) '())
        (else (append (tree->list (left-tree tree))
                      (list (root-tree tree))
                      (tree->list (right-tree tree)))))
)

; искаме да проверим дали х се среща в двоичното наредено дърво tree
; тук правим итеративен процес (опашкова рекурсия)
(define (bst-member? x tree)
  (cond ((empty-tree? tree) #f)
        ((equal? x (root-tree tree)) #t)
        ((< x (root-tree tree)) (bst-member? x (left-tree tree)))
        (else (bst-member? x (right-tree tree))))
)


; искаме да вкараме елемент в двоично наредено дърво (binary search tree - BST)
(define (bst-insert x tree)
  (cond ((empty-tree? tree) (make-leaf x))
	((> x (root-tree tree)) (bst-insert x (right-tree tree)))
	(else (bst-insert x (left-tree tree))))
)

(define example-list '(1 5 4 6 2 8 7))

; искаме да сортираме даден списък, използвайки tree->list и bst-insert
(define (sort xs)
  (tree->list (foldr bst-insert empty-tree xs))
)

