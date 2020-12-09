#lang racket
; Упражнение на функции от по-висок ред
; foldl (свиване наляво), foldr (свиване надясно)

; Всички задачи да се решат чрез foldl или foldr

; Задача 0: Да се дефинира функция (sum-sq l), която пресмята
; сумата на квадратите на елементите на дадения списък l
(define (sum-sq l)
  (foldr (lambda (elem acc) (+ (* elem elem) acc)) 0 l)
)

; Задача 1: Да се дефинира функция (reverse l), която по даден списък l
; връща обърнатия списък на l
(define (reverse l)
  (foldl cons '() l)
)

; Задача 2: Да се дефинира функция (increasing? l), която проверява
; дали елементите на списъка l образуват растяща редица
(define (increasing? l)
  (number? (foldl (lambda (elem acc) (if (equal? acc #f) #f (if (> elem acc) elem #f))) -inf.0 l))
)

; Задача 3: Да се дефинира функция (zig-zag? l), която проверява дали
; всеки от елементите в l е обграден или само от по-големи от него,
; или само от по-малки
; '(1 5 2 10 1 4 3 8) => #t
; '(1 2 3 2 4 6 5)    => #f
(define (zig-zag? l)
  (define init-state 2)
  (define was-bigger 0)
  (define was-smaller 1)
  (define (checker elem acc)
    (cond
        ((eq? acc #f) #f)
        ((not (pair? acc)) (cons elem init-state))
        ((= (cdr acc) init-state) (
                                      if (not (= elem (car acc)))
                                         (if (< elem (car acc))
                                            (cons elem was-smaller)
                                            (cons elem was-bigger)
                                          )
                                      #f
                                  ))
        ((= (cdr acc) was-smaller) (if (> elem (car acc)) (cons elem was-bigger) #f))
        ((= (cdr acc) was-bigger) (if (< elem (car acc)) (cons elem was-smaller) #f))
    )
   )
  (not (eq? (foldr checker 0 l) #f))
)
; Задача 4: Да се дефинира фуннкция (unique l), която по подаден
; списък l връща само уникалните елементи от него

; помощна функция contains? с fold
(define (contains? l x)
  (foldr (lambda (y acc) (if (= x y) #t acc)) #f l)
  ; друг вариант: (foldr or #f (map (lambda (y) (= y x)) l)
)

(define (unique l)
  (foldr (lambda (y acc) (if (contains? acc y) acc (cons y acc))) '() l)
)

; Задача 5: Да се дефинира функция (intersect l1 l2), която връща сечението
; на списъците l1 и l2 (т.е. списък съдържащ общите им елементи)
(define (intersect l1 l2)
  (foldr (lambda (x acc) (if (contains? l2 x) (cons x acc) acc)) '() l1)
)
; Задача 6: Да се дефинира функция (sublists l), която по даден списък l
; връща всички подсписъци на дадения списък
(define (sublists l)
  (define (gen-lists x l)
    (append l (map (lambda (y) (cons x y)) l))
  )
  (foldr gen-lists '(()) l)
)
