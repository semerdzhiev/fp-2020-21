#lang racket

; Граф за нас ще означава списък от двойки (ребра)
; например '((1 . 2) (2 . 3) (2 . 5) (2 . 4) (4 . 3) (5 . 4))

(define g '((1 . 2) (2 . 3) (2 . 5) (2 . 4) (4 . 3) (5 . 4)))
; '(1 2 2 3 2 5 2 4 4 3 5 4)

; '((2 . 3) (2 . 5) (2 . 4))
; '(3 5 4)

; търсим входна степен на даден връх - колко ребра влизат в него
(define (in-degree g v)
  (void)
)

; търсим изходна степен на даден връх - колко ребра излизат от него
(define (out-degree g v)
  (void)
)

; искаме списък с всички върхове на g
(define (nodes g)
  (remove-duplicates (flatten g))
  ;(remove-duplicates (foldr (lambda (currEdge currRes) (cons (from currEdge) (cons (to currEdge) currRes))) '() g))
  ;(void)
)
; '(1 2 ((3)) (4 (5))) -> (1 2 3 4 5)

; преобразуваме g към представяне със списък на съседство
; (
;  (1 (2))
;  (2 (3 4 5))
;  (3 ())
;  (4 (3))
;  (5 (4))
; )
(define (to-adjacency-list g)
  (define (neighbours v g)
    (let ((edges-starting-with-v (filter (lambda (edge) (= (car edge) v)) g)))
    (map cdr edges-starting-with-v))
  )
  (map
   (lambda (v) (cons v (list (neighbours v g))))
   (nodes g)
  )
)

; искаме да проверим дали списъкът от върхове nodes е път в графа g
(define (path? g nodes)
  (void)
)

; искаме всички (прости) пътища между два дадени върха
(define (simple-paths g from to)
  (void)
)

; искаме най-късият (прост) път между два дадени върха
(define (shortest-path g from to)
  (void)
)
