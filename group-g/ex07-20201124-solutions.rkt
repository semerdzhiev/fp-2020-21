#lang racket

; Полезни помощни функции
(define head car)
(define tail cdr)

; Зад.1
(define (sub-range i j lst)
  (drop (take lst j) i))

(define (sub-matrix i1 j1 i2 j2 m)
  (let [(the-rows (sub-range i1 i2 m))]
    (map (lambda (row) (sub-range j1 j2 row)) the-rows)))

; Зад.1 1/3 и 1 2/3
(define (any? p? lst)
  (and (not (null? lst))
       (or (p? (head lst))
           (any? p? (tail lst)))))
(define (all? p? lst)
  (not (any? (lambda (x) (not (p? x))) lst)))

; Генерира списък от всички възможни координати на горен ляв ъгъл на подматрица на m
(define (all-up-lefts m)
  (let [(num-rows (length m))
        (num-cols (length (head m)))]
    (apply append ; сплесква списък от списъци в "прост" списък
           (map (lambda (row) ; за всеки ред...
                  (map (lambda (col) (list row col)) ; ...за всяка колона
                       (range 0 num-cols)))
                (range 0 num-rows)))))

; Генерира списък от всички възможни координати на подматрица
; (горен ляв + долен десен ъгъл)
(define (all-coords m)
  (define num-rows (length m))
  (define num-cols (length (head m)))
  ; Намира макс размер на подматрица с даден горен ляв ъгъл
  (define (max-size coord)
    (min (- num-rows (car coord)) (- num-cols (cadr coord))))
  ; Генерира долен десен ъгъл на подматрица по даден горен ляв ъгъл и размер
  (define (bump coord n)
    (list (+ (car coord) n) (+ (cadr coord) n)))
  (apply append ; алтернативно: (foldr append '() ...)
         (map (lambda (coord)
                (map (lambda (len) (append coord (bump coord len)))
                     (range 1 (+ 1 (max-size coord)))))
              (all-up-lefts m))))

; Във вътрешните, помощни функции, ще представяме подматриците само чрез координатите на ъглите им.
; Самата матрица m ще ползваме имплицитно от външната среда,
; за да си спестим подаването ѝ на всички други функцийки
(define (find-submatrix ps m)
  ; дали числото el удоволетворява някой от предикатите
  (define (is-Ok el)
    (any? (lambda (p) (p el)) ps))
  ; връща дадена подматрица, "разопаковайки" координатите ѝ
  (define (get-submatrix coord)
    (sub-matrix (car coord) (cadr coord) (caddr coord) (cadddr coord) m))
  ; дали всички числа в дадена подматрица (зададена по индекси н
  (define (is-Ok-mat coord)
    (all? (lambda (row) (all? is-Ok row))
          (get-submatrix coord)))
  ; сравнява две подматрици, зададени чрез индексите си (!)
  ; по размер И позиция
  (define (>-submat coord1 coord2)
    (let [(size1 (- (caddr coord1) (car coord1)))
          (size2 (- (caddr coord2) (car coord2)))]
      (cond [(> size1 size2) coord1]
            [(> size2 size1) coord2]
            [(< (+ (car coord1) (cadr coord1))
                (+ (car coord2) (cadr coord2))) coord1]
            [else coord2])))
  ; Намира индексите на най-добрата подматрица (по критерия по-горе)
  ; измежду даден списък от индекси на подматрици
  (define (get-best-index coords)
    (foldr >-submat (head coords) (tail coords)))
  
  (let [(good-submatrices (filter is-Ok-mat (all-coords m)))]
    (if (null? good-submatrices)
        #f ; може да няма подматрици, изпълняващи условието :(
        (get-submatrix (get-best-index good-submatrices)))))

; сега (find-submatrix (list even? (lambda (x) (> x 3))) '((1 2 3) (4 5 6) (7 8 9)))
; трябва да върне '((4 5) (7 8))











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

(define (tree->list t)
  (if (empty-tree? t) '()
      (append (tree->list (left-tree t))
              (list (root-tree t))
              (tree->list (right-tree t)))))

; Зад.3
(define (bst-insert val t)
  (cond [(empty-tree? t) (make-leaf val)]
        [(< val (root-tree t))
         (make-tree (root-tree t)
                    (bst-insert val (left-tree t))
                    (right-tree t))]
        [else (make-tree (root-tree t)
                         (left-tree t)
                         (bst-insert val (right-tree t)))]))

; Зад.4
(define (tree-sort lst)
  (tree->list (foldr bst-insert empty-tree lst)))

; Зад.6
(define (is-leaf? t)
  (and (empty-tree? (left-tree t))
       (empty-tree? (right-tree t))))

; Пример за решение когато не е валиден случай да извикваме
; функцията върху празно дърво и/или няма каква валидна
; "неутрална" стойност да върнем в такъв случай.
; -> обработваме отделно всички случаи за наследниците
(define (prune t)
  (cond [(is-leaf? t) empty-tree] ; няма наследници (листо)
        [(empty-tree? (right-tree t)) ; само ляв наследник
         (make-tree (root-tree t)
                    (prune (left-tree t))
                    empty-tree)]
        [(empty-tree? (left-tree t)) ; само десен наследник
         (make-tree (root-tree t)
                    empty-tree
                    (prune (right-tree t)))]
        [else (make-tree (root-tree t) ; два наследника
                         (prune (left-tree t))
                         (prune (right-tree t)))]))
