#lang racket

; 1. За дадено естествено число n намира n+1.
(define (succ x) (+ x 1))

; 2. За дадено естествено число n намира n-1.
(define (pred x) (- x 1))

; 3. За дадено число n, връща n/2 ако n е четно, и n в противен случай.
(define (safe-div x)
  (if (even? x)
    (/ x 2)
    x))

; 4. Намира номера на подаден месец от годината.
(define (month-index m)
  (cond [(equal? m "January")    1]
        [(equal? m "February")   2]
        [(equal? m "March")      3]
        [(equal? m "April")      4]
        [(equal? m "May")        5]
        [(equal? m "June")       6]
        [(equal? m "July")       7]
        [(equal? m "August")     8]
        [(equal? m "September")  9]
        [(equal? m "October")   10]
        [(equal? m "November")  11]
        [(equal? m "December")  12]
        [else "Not a month!"]))

; 5. За дадено x проверява дали е корен на (3*x^2 - 2*x - 1).
; Полинома не се променя.
; Корени: -1/3, 1
(define (is-root? x)
    (zero? (+ -1
              (* -2 x)
              (* 3 (expt x 2)))))

; 6. Намира n!.
(define (factorial n)
  (if (= n 0) 1 (* n (factorial (- n 1)))))

; 7. Намира n-тото число на Фибоначи.
(define (fibonacci n)
  (if (< n 2)
    n
    (+ (fibonacci (- n 1))
       (fibonacci (- n 2)))))

; 8. Намира сумата на 2 естествени числа, използвайте succ и pred.
(define (add x y)
  (if (= x 0)
    y
    (succ (add (pred x) y))))

; 9. намира произведението на 2 естествени числа.
; Използвайте sum и pred.
(define (multiply x y)
  (cond [(= 0 x) 0]
        [(= 1 x) y]
        [else (add y(multiply (pred x) y))]))
