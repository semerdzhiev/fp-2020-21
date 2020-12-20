#lang racket

(define head car)
(define tail cdr)

; код от студент - обсъждахме дали е верен (да)
; и защо единият от тестовете гърми странно
(define (calc-length pair1 pair2)
  (let ([x (cdr pair1)]
        [y (cdr pair2)])
    (cons (+ (car pair2)
             (sqrt (+ (*(- (car x)
                           (car y))
                        (- (car x)
                           (car y)))
                      (*(- (cdr x)
                           (cdr y))
                        (- (cdr x)
                           (cdr y))))))
          x)))

(define (cost pts)
  (let ([length (length pts)])
    (if (< length 2)
        0
        (car (foldr calc-length
                    (cons 0 (head pts))
                    (map (lambda (x) (cons 0 x)) pts)))
     )
  )
)

; модифициран да работи код от студент
; - едновременно смятане на четирите координати
; Недостатък - inf.0 каства всички стойности до
; неточно представяне (стандартен IEEE-754 double)
(define (cover pts)
  (foldr (lambda (pt res)
           (cons (cons (min (car pt) (caar res))
                       (max (cdr pt) (cdar res)))
                 (cons (max (car pt) (cadr res))
                       (min (cdr pt) (cddr res)))))
         (cons (cons +inf.0 -inf.0)
               (cons -inf.0 +inf.0))
         pts))

(define (cover* pts)
  (let [(xs (map car pts))
        (ys (map cdr pts))]
    (cons (cons (apply min xs)
                (apply max ys))
          (cons (apply max xs)
                (apply min ys)))))
; Ако не се сетим за apply min/max
(define (minimum lst)
  (foldr min (head lst) (tail lst)))

; Пример за грозен, императивен, деструктивен код :(
(define (test x)
  (define (helper n)
    (if (= n 0)
        (void)
        (begin (set! x (+ x 1))
               (helper (- n 1)))))
  (begin (helper 10)
         x))

; За потоци
(require racket/stream)
; стриктно оценяване <-> мързеливо оценяване

; стриктно:
; (define (f x) (* x x))
; (f (+ 3 5))
; -> (f 8)
; -> (* 8 8)
; -> 64

; мързеливо (на теория):
; (f (+ 3 5))
; -> (* (+ 3 5) (+ 3 5))
; -> (* 8 8)
; -> 64

; мързеливо (на практика):
; (f (+ 3 5))
; -> (let [(x (delay (+ 3 5)))]
;      (* (force x) (force x)))
; Така ако x не се среща в тялото, няма да
; бъде изпълнена сметката за неговото оценяване

; Създаване на обещание
; в R5RS работи дори ако `a` не е дефинирана в този момент
;(define x (delay (+ a 3)))

; Специални форми:
; if, and, or, define, lambda
; cond, let, let*, letrec
; delay, quote

; Списъкът (знаем) е наредена двойка от
; глава (стойност) и опашка (също списък).
; Потокът е наредена двойка от глава (стойност) и обещание
; за "опашката му" (също поток, потенциално безкраен).

; delay е специална форма с мързеливо оценяване,
; но така написана cons-stream ще се оценява стриктно!
;(define (cons-stream h t)
;  (cons h (delay t)))
; Решението: да създадем своя специална форма
(define-syntax cons-stream
  (syntax-rules ()
    ((cons-stream h t) (cons h (delay t)))))

(define (nats-from n)
  (cons-stream n (nats-from (+ n 1))))
  ; това се "разпъва" като макро до следното:
  ;(cons n (delay (nats-from (+ n 1)))))
  ; и сега вече рекурсивното извикване е отложено :)

; Работим с потоци аналогично на списъци
; - с този интерфейс може да направим аналози
; на всички познати функции като map, filter,
; length, append, reverse, foldr и т.н.
(define (head-stream str) (car str))
(define (tail-stream str) (force (cdr str)))
; Ако ни потрябва празен поток - специална, уникална стойност
(define null-stream #f)
(define (null-stream? str) (not str)) ; само #f е #f

; Пример (за жалост доста вербозен:
(define (map-stream f str)
  (if (null-stream? str)
      null-stream
      (cons-stream (f (head-stream str))
                   (map-stream f (tail-stream str)))))