(define (accumulate op nv a b term next)
  (if (> a b) nv
      (op (term a)
          (accumulate op nv (next a) b term next))))

(define (id x) x)
(define (1+ x) (+ x 1))

(define (sum a b)
  (accumulate + 0 a b id 1+))

; Зад.1
(define (!! n)
  (accumulate * 1
              (if (odd? n) 1 2) n
              id
              (lambda (x) (+ x 2))))

; Зад.2
(define (fact n)
  (accumulate * 1 1 n id 1+))
(define (nchk n k)
  (/ (fact n) (fact (- n k)) (fact k)))

; Зад.3
; (nchk n k) = n*(n-1)*...*(n-k+1) / k*(k-1)*...*1
; Идея: множителите над и под знаменателя са равен брой
; -> групираме ги две по две
(define (nchk* n k)
  (accumulate * 1
              0 (- k 1)
              (lambda (i) (/ (- n i) (- k i)))
              1+))

; Зад.4
(define (2^ n)
  (accumulate * 1 1 n (lambda (x) 2) 1+)) ; (constantly 2)

(define (2^* n)
  (accumulate + 0 0 n (lambda (k) (nchk* n k)) 1+))

; Зад.5
; Забележка: accumulate винаги обхожда целият интервал,
; докато ръчно разписаната функция (може и с cond)
; има short-circuiting и връща лъжа при първия срещнат
; елемент, който не изпълнява предиката.
; За проба: (all? even? 1 1000000000)
(define (all? p? a b)
  ;(accumulate (lambda (x y) (and x y)) #t
  ;            a b
  ;            p?
  ;            1+)
  (if (> a b) #t
      (and (p? a)
           (all? p? (+ a 1) b)))
)

(define (complement p?)
  (lambda (x) (not (p? x))))
; по ДеМорган
(define (any? p? a b)
  (not (all? (complement p?) a b)))

; 1  2  3  4  5
;
; (and (p? 1) (and (p? 2) (and (p? 3) ...)))

; Зад. 5 1/2: Понякога е по-удобно да обходим целия
; интервал и да филтрираме някои от числата, вместо
; да мислим сложни начини за прескачане от едно на друго
(define (filter-accum p? op nv a b term next)
  (cond ((> a b) nv)
        ((p? a) (op (term a)
                    (filter-accum p? op nv (next a) b term next)))
        (else       (filter-accum p? op nv (next a) b term next))))

(define (!!* n)
  (filter-accum (if (even? n) even? odd?)
                * 1
                1 n
                id 1+))

; 1    2    3    4    5
;
; 1         3         ....

; Зад.6
(define (divisors-sum n)
  (filter-accum (lambda (x) (zero? (remainder n x)))
                + 0
                1 n
                id 1+))

; по-хакаво решение
(define (divisors-sum* n)
  (accumulate + 0
              1 n
              ; "фалшива" функция за общ член: делителите се
              ; трансформират в себе си, а другите числа в 0
              (lambda (x) (if (zero? (remainder n x)) x 0))
              1+))

; Зад.7
; Брои за колко от числата в интервала
; [a;b] е изпълнен предиката p?
(define (count p? a b)
  (accumulate + 0 a b (lambda (x) (if (p? x) 1 0)) 1+))

; Зад.8
; Вече имаме няколко начина да проверим дали число е просто
; Използваме accumulate, макар и индиректно (няма нужда да пишем едно и също по два пъти)
(define (prime? n)
  (and (> n 1)
       (zero? (count (lambda (x) (zero? (remainder n x)))
                     2
                     (sqrt n)))))

(define (prime?* n)
  (and (> n 1)
       (not (any? (lambda (x) (zero? (remainder n x)))
                  2
                  (sqrt n)))))

; Зад.8*
; Понякога работим не само с числа :)
(define (compose f g)
  (lambda (x) (f (g x))))
(define (repeat n f)
  (accumulate compose id 1 n (lambda (x) f) 1+))
; ((repeat 5 1+) 10) -> 15
  


   