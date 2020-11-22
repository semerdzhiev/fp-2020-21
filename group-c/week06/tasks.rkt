#lang racket
; Графи
; Формално представяне: G(V, E)
; V - множество от върхове
; E - множество от наредени двойки (ориентиран граф) или двуелементни множества (неориентиран граф)
; За целта на задачите, E ще се представя като списък от наредени двойки,
; а върховете ще са в списък и индексирани с цели числа
; '((1 . 2) (2 . 3) (1 . 4) (5 . 6) (2 . 4) (3 . 5))

; Задача 1: Да се дефинира функция (nodes edges),
; която приема списък с ребрата edges на даден ориентиран граф
; (в който всяко ребро е представено като двойка (from . to))
; и връща списък, съдържащ всички върхове на съответния граф.
; Начин 1: акумулиране на резултат
(define (push-unique elem list)
 (
  if (member elem list)
     list
     (cons elem list)
  )
)

(define (nodes edges)
  (
   foldl
        (lambda (edge l)
           (
            push-unique (cdr edge) (push-unique (car edge) l)
           )
         )
         null
         edges
   )
)
; foldl <accumulate-function> <accumulator-initial-value> <list-to-accumulate>

; Начин 2: remove-duplicates
(define (nodes2 edges)
  (remove-duplicates (append (map car edges) (map cdr edges)))
)

; Задача 2: Да се дефинира функция (adjacency-list edges),
; която приема списък с ребрата edges на даден ориентиран граф
; (в който всяко ребро е представено като двойка (from . to))
; и връща списъка на съседите на всички върхове.
; (т.е. върховете, към които има ребро от даден връх)
;
; Пример:
; '(
;   (1 . '(2 4))
;   (2 . '(3 4))
;   (3 . '(5))
;   (4 . '())
;   (5 . '(6))
;   (6 . '())
;  )

(define (adjacency-list edges)
  (define (get-nodes start)
    (cons start (list (map cdr (filter (lambda (edge) (= (car edge) start)) edges))))
   )
  (map get-nodes (nodes edges))
)

; Задача 3: Да се дефинира функция (path? edges nodes),
; която приема списък с ребрата edges на даден
; ориентиран граф и списък от върхове nodes и връща
; дали списъкът nodes е път в графа описан от edges.
;
; Пример
; '((1 . 2) (2 . 3) (1 . 4) (5 . 6) (2 . 4) (3 . 5))
(define (drop-last l)
  (
   cond
    [(null? l) '()]
    [(null? (cdr l)) '()]
    [else (cons (car l) (drop-last (cdr l)))]
   )
)

(define (path? edges nodes)
 (define path-edges (map cons (drop-last nodes) (cdr nodes)))
 (foldl (lambda (path-edge acc) (if (member path-edge edges) acc #f)) #t path-edges)
)

; Задача 4: Да се дефинира функция (simple-paths edges k from),
; която приема списък с ребрата edges на даден ориентиран граф,
; цяло число k и идентификатор на връх from и връща всички
; прости пътища с дължина k, които започват от from.
; (NB! прост път - върховете не се повтарят)

; Задача 5: Да се дефинира функция (all-simple-paths edges from to),
; която приема списък с ребрата edges на даден ориентиран граф
; и два идентификатора на върхове from и to и връща всички прости пътища,
; които започват от from и завършват в to.

(define (filter-edges e n) (filter (lambda (x) (not (or (= (car x) n) (= (cdr x) n)))) e))
(define (neighbors e n) (map cdr (filter (lambda (x) (= (car x) n)) e)))

(define (all-simple-paths edges from to)
  (define relevant-nodes (map cdr (filter (lambda (x) (= (car x) from)) edges)))
  (define filtered-edges (filter (lambda (x) (not (or (= (car x) from) (= (cdr x) from)))) edges))
  (define (cons-from l) (cons from l))
  (if (= from to)
      (list (list to))
      (foldl append '() (map (lambda (n) (map cons-from (all-simple-paths filtered-edges n to))) relevant-nodes))
  )
)

; Задача 6*: Да се дефинира функция (shortest-path edges from to),
; която приема списък с ребрата edges на даден ориентиран граф
; и идентификатори на върховете from и to и връща произволен най-къс път от from до to
(define (shortest-path edges from to)
  (define l (all-simple-paths edges from to))
  (if (null? l)
      null
      (foldr (lambda (p acc) (if (> (length acc) (length p)) p acc)) (car l) (cdr l))
  )
)
