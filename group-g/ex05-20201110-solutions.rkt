#lang racket
; 2 3 5

;  cons
; 2   cons
;    3   cons
;       5   '()

;(define (length lst)
;  (if (null? lst) 0
;      (+ 1 (length (cdr lst)))))

; За удобство:
(define head car) ; приема списък от "неща" и връща първото "нещо"
(define tail cdr) ; приема списък от неща и връща също списък от нещата без първото

(define (member? x lst)
  (cond ((null? lst) #f)
        ((equal? (head lst) x) #t) ; заб.: вградената member тук връща lst
        (else (member? x (tail lst)))))
  ;(and (not (null? lst))
  ;     (or (= (head lst) x)
  ;         (member? x (tail lst)))))

; И функциите за списъци могат да са итеративни
(define (length* lst)
  (define (helper lst res)
    (if (null? lst) res
        (helper (tail lst) (+ res 1))))
  (helper lst 0))

;(define (map f lst)
;  (if (null? lst) '()
;      (cons (f (head lst))
;            (map f (tail lst)))))
(define (map* f lst)
  (define (helper lst res)
    (if (null? lst) res
        (helper (tail lst)
                ;(cons (f (head lst)) res) ; обръща резултата (!)
                (append res (list (f (head lst)))) ; а това е квадратично(!)
                )))
  (helper lst '()))

; helper '(1 2 3) '()
; helper '(2 3) '(1)
; helper '(3) '(2 1)

(define (filter p? lst)
  (cond [(null? lst) '()]
        [(p? (head lst)) (cons (head lst)
                               (filter p? (tail lst)))]
        [else (filter p? (tail lst))]))

; Зад.1
(define (take n lst)
  (if (or (= n 0) (null? lst))
      '()
      (cons (head lst)
            (take (- n 1) (tail lst)))))
(define (drop n lst)
  (if (or (= n 0) (null? lst))
      lst
      (drop (- n 1) (tail lst))))

; Зад.2
(define (all? p? lst)
  (or (null? lst)
      (and (p? (head lst))
           (all? p? (tail lst)))))
; Дори така написани, симетрията между двете е очевидна
(define (any? p? lst)
  (and (not (null? lst))
       (or (p? (head lst))
           (any? p? (tail lst)))))

; Зад. 3&4
(define (zipWith f lst1 lst2)
  (if (or (null? lst1) (null? lst2))
      '()
      (cons (f (head lst1) (head lst2))
            (zipWith f (tail lst1) (tail lst2)))))
(define (zip lst1 lst2)
  (zipWith cons lst1 lst2))

; Зад.5
(define (sorted? lst)
  (or (null? lst)
      (null? (tail lst))
      (and (<= (head lst) (head (tail lst)))
           (sorted? (tail lst)))))

; Пример: ако трябва да използваме дължината на
; подадения списък на всяка итерация.
;(define (neshto lst)
;  (define (helper lst n) ; Инварианта: (length lst) = n
;    (...)) ; Важно - да поддържаме инвариантата при рекурсивните извиквания
;  (helper lst (length lst)))

; Зад.6
; "Класическо" решение, в което се извикваме рекурсивно за опашката
; и преценяваме дали да добавим главата към резултата
(define (uniques lst)
  (if (null? lst) '()
      (let [(rest (uniques (tail lst)))] ; да не преизчисляваме нещо повече от веднъж
        (if (member (head lst) rest)
            rest
            (cons (head lst) rest)))))

; По-просто рекурсивно решение
(define (uniques* lst)
  (if (null? lst) '()
      (cons (head lst)
            (uniques* (filter (lambda (x) (not (equal? x (head lst))))
                             (tail lst))))))

; Итеративно решение
(define (uniques** lst)
  (define (helper lst res)
    (cond [(null? lst) res]
          [(member (head lst) res) (helper (tail lst) res)]
          [else (helper (tail lst) (cons (head lst) res))]))
  (helper lst '()))
; Забележка: и трите решения са квадратични алгоритми
; заради линейното обхождане на member и filter

; Обобщено "насъбиране" на елементи от списък:
; "комбинираме" главата на дадения списък с
; резултата от насъбирането на опашката му.
(define (foldr op nv lst)
  (if (null? lst) nv
      (op (head lst)
          (foldr op nv (tail lst)))))

(define (maximum lst)
  (foldr max (head lst) (tail lst)))
  ;(foldr max -inf.0 lst))

(define (uniques*** lst)
  (foldr (lambda (el res)
           (if (member el res) res (cons el res)))
         '()
         lst))

(define (length** lst)
  (foldr (lambda (el res) (+ 1 res)) 0 lst))
(define (map** f lst)
  (foldr (lambda (el res) (cons (f el) res)) '() lst))
(define (filter* p? lst)
  (foldr (lambda (el res)
           (if (p? el) (cons el res) res)) '() lst))

; Зад.7
(define (insert val lst)
  (cond [(null? lst) (list val)]
        [(> val (head lst)) (cons (head lst) (insert val (tail lst)))]
        [else (cons val lst)]))

; Зад.8
; Дори да не използваме foldr, бихме написали код, аналогичен на неговия
; => тогава се сещаме да го ползваме :)
; Очевидно квадратичен алгоритъм
(define (insertion-sort lst)
  (foldr insert '() lst))

; Сортиране със същата асимптотична сложност, както в императивен език
(define (quicksort lst)
  (if (or (null? lst) (null? (tail lst)))
      lst
      (let [(pivot (head lst))
            (rest (tail lst))]
      (append (quicksort (filter (lambda (x) (< x pivot))
                                 rest))
              (list pivot)
              (quicksort (filter (lambda (x) (>= x pivot))
                                 rest))))))

; Зад.9
; дали i1 е подинтервал на i2
(define (sub? i1 i2)
  (and (>= (car i1) (car i2))
       (<= (cdr i1) (cdr i2))))
; дължина на интервал
(define (int-length i)
  (- (cdr i) (car i)))
; като >, но за интервали :)
(define (>-int i1 i2)
  (if (> (int-length i1) (int-length i2)) i1 i2))
; максимален по дължина интервал
(define (max-interval lst)
  ; При търсене на мин/макс взимаме първия елемент
  ; като първоначален и обхождаме останалите.
  (foldr >-int (head lst) (tail lst)))

(define (longest-interval-subsets lst)
  (define longest (max-interval lst)) ; за да не го преизчисляваме непрекъснато
  (filter (lambda (i) (sub? i longest)) lst))

; Зад.10
(define (compose f g)
  (lambda (x) (f (g x))))
(define (1+ x) (+ x 1))
(define (sq x) (* x x))
(define (^3 x) (* x x x))

; Да подаваме произволен брой аргументи е синтактична
; захар за подаване на списък от неща
;(define (compose-n fns) ; (compose-n (list sq 1+))
(define (compose-n . fns) ; (compose-n sq 1+)
  (foldr compose (lambda (x) x) fns))

; (compose-n sq 1+ ^3)
; (foldr compose id '(sq 1+ ^3))
; (compose sq (foldr compose id '(1+ ^3))
; (compose sq (compose 1+ (foldr compose id '(^3)))
; ...
; (compose sq (compose 1+ (compose ^3 id)))
; (compose sq (compose 1+ (lambda (x) (^3 (id x)))
; Тук ползваме, че ((lambda (x) (f x)) y) <=> (f y)
; (compose sq (lambda (x) (1+ (^3 (id x)))
; (sq (1+ (^3 (id x))))

; Зад.11
(define (group-by f lst)
  (define returned (uniques (map f lst)))
  (define (elements-for x)
    (filter (lambda (el) (equal? x (f el))) lst))
  (map (lambda (x)
         (list x (elements-for x)))
       returned))

; Зад.12
; Функция, която приема произволен брой аргументи, но поне един (!)
; apply is our best friend here
(define (zipWith* f . lsts)
  (if (or (null? lsts) (any? null? lsts))
      '()
      (cons (apply f (map head lsts))
            (apply zipWith* f (map tail lsts)))))
  

        











