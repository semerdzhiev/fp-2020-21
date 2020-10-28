#lang racket

; NOTE: Суфикса * е защото съществуват вградени процедури със същите имена.

; 1. Намира дължината на списъка lst.
(define (length* lst)
  (if (null? lst)
    0
    (+ 1
       (length* (cdr lst)))))
; 2. Намира сумата на елементите на списъка lst. Предполага се че са само числа.
(define (sum lst)
  (if (null? lst)
    0
    (+ (car lst)
       (sum (cdr lst)))))

; 3. Връща последния елемент на списъка lst.
(define (last* lst)
  (if (null? (cdr lst))
    (car lst)
    (last (cdr lst))))

; 4. Връща n-тия елемент на списъка lst.
(define (nth n lst)
  (define (help i lst)
    (cond [(null? lst) 'not-found]
          [(= i n) (car lst)]
          [else (help (+ 1 i) (cdr lst))]))
  (help 0))

; 5. Връща конкатенацията на lst1 и lst2.
(define (concat lst1 lst2)
  (if (null? lst1)
    lst2
    (cons
      (car lst1)
      (concat (cdr lst1) lst2))))

; 6. Прилага fn над елементите на lst, връща новия списък.
(define (map* f lst)
  (if (null? lst)
    lst
    (cons
      (f (car lst))
      (map* f (cdr lst)))))

; 7. Връща списък от елементите на lst, за които pred е вярно.
(define (filter* p lst)
  (cond [(null? lst) lst]
        [(p (car lst))
         (cons
           (car lst)
           (filter* p (cdr lst)))]
        [else (filter* p (cdr lst))]))

; 8. Връща списък от 2 елемента - списъци
;   - Елементите от lst изпълняващи предиката p
;   - Останалите елементи на lst
(define (partition* p lst)
  (define (help truthy falsy lst)
    (cond [(null? lst) (cons truthy (list falsy))]
          [(p (car lst))
           (help (cons (car lst) truthy)
                 falsy
                 (cdr lst))]
          [else (help truthy
                      (cons (car lst) falsy)
                      (cdr lst))]))
  (help '() '() lst))

; NOTE: Или по-лесно - filter в-ху предиката и filter в-ху complement варианта му.

; NOTE: Вградената функция partition работи малко по-различно
;       - връща (values lst1 lst2)
