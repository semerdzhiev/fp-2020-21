#lang racket
(require rackunit)
(require rackunit/text-ui)

; Функцията accumulate, може да стане още по-абстрактна.
; Искаме числата, върху които прилагаме операцията да удовлетворяват някакво условие.
; Например, искам сумата на всички прости числа в интервал.

(define (accumulate-filter condition? operation null-value start end term next)
  (void)
)


(define (id x) x)
(define (inc x) (+ x 1))
(define (prime? n)
  (define (helper current)
    (cond ((= n 1) #f)
          ((> current (sqrt n)) #t)
          ((= (remainder n current) 0) #f)
          (else (helper (+ current 1)))))
  (helper 2)
)

(define tests
  (test-suite "Accumulate-filter sum tests"
    (check-equal? (accumulate-filter even? * 1 1 5 id inc) 8)
    (check-equal? (accumulate-filter prime? + 0 1 100 id inc) 1060)
  )
)

(run-tests tests 'verbose)