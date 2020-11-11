#lang racket

; TODO let, let*, letrec

; Двоично дърво ще представяме по следния начин:
; 1) '() е двоично дърво.
; 2) (root left right) е двоично дърво, точно когато
;   left и right са двоични дървета, а root е просто стойността в корена.

; Нека си дефинираме няколко функции за работа с двоични дървета

; Проверяваме по дефиницията
(define (tree? t)
  (or (null? t)
      (and (list? t)
           (= (length t) 3)
           (tree? (cadr t))
           (tree? (caddr t)))))

(define root car)

(define left cadr)

(define right caddr)

(define (make-tree root left right)
  (list root left right))

(define empty? null?)

; Едно дърво е листо ако има вида (root '() '()),
; тоест текущия връх няма наследници
(define (leaf? t)
  (and (empty? (left t))
       (empty? (right t))))


; Пример:
;   1
;  / \
; 2   3
;      \
;       4
;
; Бихме го записали:
'(1 (2 () ())
    (3 ()
       (4 () ())))


; Имплементирайте следните функции за двоични дървета:

; Намира броя на листата в tree.
(define (count-leaves tree) void)

; Връща ново дърво, в което f е приложена над всеки връх от tree.
(define (map-tree f tree) void)

; Връща списък от всички върхове на разстояние n от корена на tree.
(define (level n tree) void)

; Обхождане на дърво, функциите да връщат списък от върховете в реда на обхождането им

; корен-ляво-дясно
(define (pre-order t) void)

; ляво-корен-дясно
(define (in-order t) void)

; ляво-дясно-корен
(define (post-order t) void)


; Асоциативен списък ще наричаме списък от двойки от вида (key . value)
; Още познато като map или dictionary (речник)

; Ето и някой основни функции, за да можем
; като за начало да конструираме такива списъци

; По функция и списък от ключове, ще направим асоциативен списък
; с елементи от вида (key . fn(key))
(define (make-alist fn keys)
  (map (lambda (key)
         (cons key (fn key)))
       keys))

; Вече можем и да добавяме елементи в нашия списък
(define (add-assoc key value alist)
  (cons (cons key value)
        alist))

(add-assoc 'purpose 42 '()) ; '((purpose . 42))

; Ще е хубаво да имаме и функции с които да вземем
; само ключовете или само стойностите на списъка
(define (alist-keys alist)
  (map car alist))


; Имплементирайте следните функции за работа със асоциативни списъци

; Връща списък от стойностите на асоциативен списък
(define (alist-values alist) void)

; По дадени ключ и асоциативен списък, връща стойността от първата намерена двойка с ключа
(define (alist-assoc key alist) void)

; По даден ключ изтрива първата съответстваща двойка със същия ключ
(define (del-assoc key alist) void)
