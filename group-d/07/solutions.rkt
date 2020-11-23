#lang racket

; Поток е списък, чиито елементи се оценяват отложено
; 1) '() е поток
; 2) (h. t) е поток точно когато:
;   - h е произволен елемент
;   - t е promise за поток.

(define-syntax cons-stream
  (syntax-rules () ((cons-stream h t)
                    (cons h (delay t)))))

; Ето и базовите функции за работа с потоци
; Когато ни трябва елемент от потока просто го взимаме (той е първият)
(define head car)

; Когато искаме да вземем опашката на потока, я оценяваме с force
(define (tail s)
  (force (cdr s)))

; Доста често ще искаме да взимаме елементи от поток.
; Нека видим как бихме имплементирали функцията take за потоци.
(define (stream-take n s)
  (if (or (zero? n) (null? s))
    '()
    (cons (head s)
          (stream-take (- n 1) (tail s)))))

; Имплементирайте следните функции, генериращи безкрайни потоци

; Генерира безкраен поток от стойности v
; (repeat 1)
; (1 . #<promise>)
; (stream-take 5 (repeat 1))
; (1 1 1 1 1)
(define (repeat v)
  (cons-stream v (repeat v)))

; Генерира безкрайния поток x, f(x), f(f(x)), ...
(define (iterate f x)
  (cons-stream x (iterate f (f x))))

; Генерира безкраен поток от елементите на lst
; (cycle '(1 2 3)) би създало потока:
; 1, 2, 3, 1, 2, 3, 1 ...
(define (cycle lst)
  (define (help lst-tmp)
    (if (null? lst-tmp)
      (help lst)
      (cons-stream (car lst-tmp)
                   (help (cdr lst-tmp)))))
  (help lst))


; Функциите от миналия път за асоциативни списъци

(define (make-alist fn keys)
  (map (lambda (key)
         (cons key (fn key)))
       keys))

(define (add-assoc key value alist)
  (cons (cons key value)
        alist))

(define (alist-keys alist)
  (map car alist))

(define (alist-values alist)
  (map cdr alist))

(define (alist-assoc key alist)
  (cond [(null? alist) '()]
        [(equal? (caar alist) key) (cdar alist)]
        [else (alist-assoc key (cdr alist))]))

(define (del-assoc key alist)
  (filter (lambda (alist-pair)
            (not (equal? (car alist-pair) key)))
          alist))


; Граф ще представяме като списък на съседство

; Няколко функции за работа с графи:
;
; Можем да конструираме граф само с върхове и без ребра
(define (make-graph vs)
  (map list vs))

; проверява дали графа g е празен.
(define empty-graph? null?)

; Списък от първите елементи на подсписъците на g
; са точно върховете на g.
; Но ние вече имаме функция която има същата дефиниция
(define vertices alist-keys)

; Добавяме списък от върха v,
; тоест той първоначално няма ребра до други върхове.
(define (add-vertex v g)
  (cons (list v) g))


; Имплементирайте следните функции за работа с графи
; Може да ползвате горните функции за асоциативни списъци

; връща списък от всички ребра на графа g.
(define (children-edges vs)
  (map (lambda (v) (cons (car vs) v))
       (cdr vs)))

(define (edges g)
  (apply append (map children-edges g)))

; връща списък от децата на върха v в g.
(define (children v g)
  (alist-assoc v g))

; проверява дали има ребро от върха u до върха v в g.
(define (edge? u v g)
  (not (null? (member v (children u g)))))

; връща списък от прилаганията на функцията f върху децата на v в g.
(define (map-children v f g)
  (map f (children v g)))

; връща първото дете на v в g, което е вярно за предиката p.
(define (search-child v p g)
  (define (help-search vs)
    (cond [(null? vs) '()]
          [(p (car vs)) (car vs)]
          [else (help-search (cdr vs))]))
  (help-search (children v g)))

; премахване на върха v от графа g заедно с ребрата до него.
(define (remove-vertex v g)
  (map (lambda (xs)
         (filter (lambda (x) (not (equal? x v))) xs))
       (del-assoc v g)))

; добавяне на ребро от u до v в g.
(define (add-if-missing x l)
  (if (member x l)
      l
      (cons x l)))

(define (add-edge u v g)
  (let ((g-with-u-v (add-vertex v (add-vertex u g))))
    (add-assoc u
               (add-if-missing v (children u g-with-u-v))
               g-with-u-v)))

; премахване на ребро от u до v в g.
(define (remove-edge u v g)
  (add-assoc u
             (remove v (children u g))
             g))


; Имплементирайте следните функции за графи.

; връща степента на върха v в графа g.
(define (degree v g)
  (length (alist-assoc v g)))

; проверява дали графа g е симетричен.
(define (every? p l)
  (or (null? l)
      (and (p (car l))
           (every? p (cdr l)))))

(define (symmetric? g)
  (every? (lambda (edge)
            (edge? (cadr edge) (car edge) g))
          (edges g)))

; инвертира графа g. Тоест за всяко ребро (u,v) в g новият граф ще има реброто (v,u).
(define (invert g)
  (foldl (lambda (edge g-inverted)
           (add-edge (cadr edge) (car edge) g-inverted))
         (make-graph (vertices g))
         (edges g)))

; проверява дали има път между върховете u и v в графа g.
(define (search p l)
  (and (not (null? l))
       (or (p (car l))
           (search p (cdr l)))))

(define (path? u v g)
  (define (dfs path)
    (let ((current (car path)))
      (or (equal? current v)
          (and (not (member current (cdr path)))
               (search-child current
                             (lambda (child)
                               (dfs (cons child path)))
                             g)))))
    (not (search (lambda (vertex)
                 (dfs (list vertex)))
               (vertices g))))

; проверява дали графа g е ацикличен.
(define (acyclic? g)
  (define (dfs path)
    (let ((current (car path)))
      (or (member current (cdr path))
          (search-child current
                        (lambda (child)
                          (dfs (cons child path)))
                        g))))
    (not (search (lambda (vertex)
                 (dfs (list vertex)))
               (vertices g))))

