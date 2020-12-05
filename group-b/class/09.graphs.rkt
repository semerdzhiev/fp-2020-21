#lang racket

; Граф за нас ще означава списък от двойки (ребра)
; например '((1 . 2) (2 . 3) (2 . 5) (2 . 4) (4 . 3) (5 . 4))

(define g '((1 . 2) (2 . 3) (2 . 5) (2 . 4) (4 . 3) (5 . 4)))

; търсим входна степен на даден връх - колко ребра влизат в него
(define (in-degree g v)
  (length (filter (lambda (x) (= (cdr x) v)) g))
)

; търсим изходна степен на даден връх - колко ребра излизат от него
(define (out-degree g v)
  (length (filter (lambda (x) (= (car x) v)) g))
)

; искаме списък с всички върхове на g
(define (nodes g)
  (remove-duplicates (flatten g))
  ;(remove-duplicates (foldr (lambda (currEdge currRes) (cons (from currEdge) (cons (to currEdge) currRes))) '() g))
)
; (flatten (1 2 ((3)) (4 (5))) -> (1 2 3 4 5)

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
; 1 2 3 4 5
; 1 2 3 4
; 2 3 4 5
; zip
; '((1 . 2) (2 . 3) (3 . 4) (4 . 5))
(define (path? g nodes)
  (define (remove-last list)
    (if(null? list) '() 
       (reverse (cdr (reverse list))))
  )
  (define remove-first cdr)
  ; (zip '() '(1 2 3)) -> '()
  ; (zip '(1) '(2 3)) -> '((1 2))
  (define (zip xs ys)
    (if (or (null? xs) (null? ys))
        '()
        (cons (cons (car xs) (car ys)) (zip (cdr xs) (cdr ys)))))

  (define (all? p? xs)
    (cond ((null? xs) #t)
          ((not (p? (car xs))) #f)
          (else (all? p? (cdr xs)))))
        

  (let ((path-edges (zip (remove-last nodes) (remove-first nodes))))
    (all? (lambda (path-edge) (member path-edge g)) path-edges)
  )
)

; искаме всички (прости) пътища между два дадени върха
(define (simple-paths g from to)
  (void)
)

; искаме най-късият (прост) път между два дадени върха
(define (shortest-path g from to)
  (void)
)
