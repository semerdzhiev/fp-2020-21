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
  (cond ((null? lst) '())
        ((p? (head lst)) (cons (head lst)
                               (filter p? (tail lst))))
        (else (filter p? (tail lst)))))

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
(define (neshto lst)
  (define (helper lst n) ; Инварианта: (length lst) = n
    (...)) ; Важно - да поддържаме инвариантата при рекурсивните извиквания
  (helper lst (length lst)))











