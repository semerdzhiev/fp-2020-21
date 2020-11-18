#lang r5rs
; Задача 1: Да се дефинира функция (revlex-less a b), която проверява дали a е преди b в лексикографска наредба (откъм последния символ)
; (revlex-less 9431 90) #f
(define (revlex-less a b)
  (define lastA (remainder a 10))
  (define lastB (remainder b 10))
  (
   if (= a b)
      #f
      (
       if (< lastA lastB)
          #t
          (
           if (> lastA lastB)
              #f
              (revlex-less (floor (/ a 10)) (floor (/ b 10)))
              )
          )
      )
  )

; Задача 2: Да се дефинира функция (nset-accumulate op term init s), която работи сходно на функцията accumulate, но прилага (op) върху елементите на множеството s
; 8 (1000) => { 3 }
; 13 (1101) => { 0, 2, 3 }
(define (id x) x)
(define (nset-accumulate op term init s)
  (define (nset-acc-helper op term init s n)
    (
     if (= s 0)
        init
        (
         if (= (remainder s 2) 1)
            (nset-acc-helper op term (op init (term n)) (quotient s 2) (+ n 1))
            (nset-acc-helper op term init (quotient s 2) (+ n 1))
            )
        )
    )
  (nset-acc-helper op term init s 0)
  )
; (nset-accumulate - id 0 13) => ((0 - 0) - 2) - 3

; Задача 3: Да се дефинира функция (nset-revlex-min s), която намира най-малкия (според наредбата дефинирана в Задача 1) елемент на множеството s. Ако множеството е празно, функцията да връща #f.
(define (nset-revlex-min s)
  (define (op acc x)
    (
     if (not acc)
        x
        (
         if (revlex-less acc x)
            acc
            x
            )
        )
    )
  (nset-accumulate op id #f s)
  )

; Задача 4: В даден ресторант постоянно получават заявки за резервации за различни времена от деня и с различна продължителност. За да организират оптимален работен график, трябва да имат информация за най-натоварените части на деня. Да се дефинира функция (find-busiest reservations), която по списък с резервации намира най-натоварения интервал и колко резервации има за него. Резервациите са наредени двойки от естествени числа, сигнализиращи начало и край на резервацията. Резервации с начало не по-малко от края считаме за невалидни.

; помощни функции
(define (filter pred l)
  (
   if (null? l)
      l
      (
       if (pred (car l))
          (append (list (car l)) (filter pred (cdr l)))
          (filter pred (cdr l))
          )
      )
  )

(define (sort ls)
  (
   if (null? ls)
      ls
      (
       append
       (sort (filter (lambda (x) (< x (car ls))) (cdr ls)))
       (list (car ls))
       (sort (filter (lambda (x) (>= x (car ls))) (cdr ls)))
       )
      )
  )

; Функцията връща по-натоварен от 2 дадени интервала
(define (get-busier-slot slot1 slot2)
  (if (< (cdr slot1) (cdr slot2))
      slot2
      slot1
      )
  )

(define (find-busiest reservations)
  (define valid-reservations (filter (lambda (res) (< (car res) (cdr res))) reservations))
  (define (get-starts res) (sort (map car res)))
  (define (get-ends res)   (sort (map cdr res)))
  (define (reservations-helper starts-left ends-left current-busiest current-accumulating)
    (
     if (null? starts-left)
        (get-busier-slot current-busiest current-accumulating)
        (
         if (< (car starts-left) (car ends-left))
            (
             reservations-helper
             (cdr starts-left)
             ends-left
             current-busiest
             (cons
              (cons (car starts-left) (car ends-left))
              (+ (cdr current-accumulating) 1)
              )
             )
            (
             if (= (car starts-left) (car ends-left))
                (
                 reservations-helper
                 (cdr starts-left)
                 (cdr ends-left)
                 current-busiest
                 (cons
                  (cons (car current-accumulating) (cadr ends-left))
                  (cdr current-accumulating)
                  )
                 )
                (
                 reservations-helper
                 starts-left
                 (cdr ends-left)
                 (get-busier-slot current-busiest current-accumulating)
                 (cons
                  (cons (car current-accumulating) (cadr ends-left))
                  (- (cdr current-accumulating) 1)
                  )
                 )
                )
            )
        )
    )
  (reservations-helper
   (get-starts valid-reservations)
   (get-ends valid-reservations)
   (cons (cons 0 0) 0)
   (cons (cons 0 0) 0)
   )
  )

; Примери:
; ((1 . 5), (2 . 4), (2 . 7), (3 . 5)) => ((3 . 4) . 4)
; ((1 . 10), (2 . 5), (4 . 7), (5 . 7), (6 . 7)) => ((6 . 7) . 4)
