; Зад.1
; Естественото рекурсивно решение
(define (toBinary n)
  (if (= n 0) 0
      (+ (remainder n 2) (* 10 (toBinary (quotient n 2))))))

; 42 0 ->     0
; 21 1 ->    10  (+ res (* (remainder n 2) (expt 10 pos)))
; 10 ->   010
; 5  ->  1010

; Итеративно решение
(define (toBinary* n)
  ; Инварианта: pos е индекса на този бит от резултата,
  ; който ще получим преди деление на n на 2
  (define (helper n res pos)
    (if (= n 0) res
        (helper (quotient n 2)
                (+ res (* (remainder n 2) (expt 10 pos)))
                (+ pos 1))))
  (helper n 0 0))

; Зад.2
; Аналогична на горната :)
(define (toDecimal n)
  (if (= n 0) 0
      (+ (remainder n 10) (* 2 (toDecimal (quotient n 10))))))

; Алтернативен синтаксис за дефиниция на функции
; - като обикновени стойности (числа, стрингове и т.н.)
; (define (fma x y z) (+ x (* y z)))
(define fma (lambda (x y z) (+ x (* y z))))
(define x 5)

; Зад.3
(define (constantly c)
  (lambda (x) c))

; Зад.4
(define (flip f)
  (lambda (x y) (f y x)))

; Зад.5
(define (complement p?)
  (lambda (x) (not (p? x))))

; Зад.6
(define (compose f g) ; (f.g)(x) = f(g(x))
  (lambda (x) (f (g x))))

(define ^2 (lambda (x) (* x x))) ; (define (^2 x) (* x x))
(define 1+ (lambda (x) (+ x 1)))
(define id (lambda (x) x))

; Зад.7
; Забележка: по-добре
; (if <нещо> (lambda (x) ...) (lambda (x) ...))
; вместо
; (lambda (x) (if <нещо> ... ...))
; -> второто подлежи на опростяване и е по-смислено.
(define (repeat n f)
  (if (= n 0) id ; идентитетът е неутралната стойност за композицията
                 ; алтернативно - (if (= n 1) f ...)
      (compose f (repeat (- n 1) f))
      ; алтернативно: (lambda (x) (f ((repeat (- n 1) f) x)))
      ; но това е очевидно същото като тялото на compose
))
; Забележка: за всяка функция f е вярно, че (lambda (x) (f x))
; е същото като просто f -> така опростяваме изрази
; (това се нарича ета-редукция)

; Зад.8
; По-малко dx води до проблеми при смятане на n-та производна.
; По-голямо dx пък - при първа/втора производна...
(define dx 0.01)
(define (derive f)
  (lambda (x) (/ (- (f (+ x dx)) (f x)) dx)))

; Зад.9: Алтернативни решения
(define (derive-n n f)
  (if (= n 0) f
      (derive (derive-n (- n 1) f))))

; Прилагаме процедурата "n-кратно диференциране" (което е очевидно функция) над f
(define (derive-n* n f)
  ((repeat n derive) f))

; Зад.10
(define (twist k f g)
  (if (= k 0) id
      (lambda (x) (f (g ((twist (- k 2) f g) x))))
      ; алтернативно - (compose f (compose g (twist ...)))
))













