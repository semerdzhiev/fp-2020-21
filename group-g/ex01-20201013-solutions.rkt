; Зад.1
(define (interval-sum a b)
  (define (helper start sum)
    (if (> start b) sum
        (helper (+ start 1) (+ sum start))))
  (helper a 0))

; Зад.2
(define (fast-expt x n)
  (define (sq x) (* x x))
  (cond ((= n 0) 1)
        ((even? n) (sq (fast-expt x (quotient n 2))))    ;   (x^(n/2))^2
        (else (* x (sq (fast-expt x (quotient n 2))))))) ; x*(x^(n/2))^2

; Зад.3
(define (last-digit n)
  (remainder n 10))

(define (count-digit d n)
  (define (helper newN count)
    (cond ((= newN 0) count)
          ((= d (last-digit newN))
             (helper (quotient newN 10) (+ count 1)))
          (else (helper (quotient newN 10) count))))
  (if (= n 0) (if (= d 0) 1 0)
      (helper n 0)))

; (count-digit 3 132)
; (helper 132 0)
; (helper 13 0)
; (helper 1 1)
; (helper 0 1)
; -> 1

; Зад.4
(define (reverse-int n)
  (define (helper newN res)
    (if (= newN 0) res
        (helper (quotient newN 10)
                (+ (* res 10) (last-digit newN)))))
  (helper n 0))

; (reverse-int 12345)
; (helper 12345 0)
; (helper 1234 5)
; (helper 123 54)
; (helper 12 543)
; (helper 1 5432)
; (helper 0 54321)

; Зад.5
(define (palindrome? n)
  (= n (reverse-int n)))

; Зад.6
(define (divisors-sum n)
  (define (helper i sum)
    (cond ((> i n) sum)
          ((= 0 (remainder n i))
             (helper (+ i 1) (+ sum i)))
          (else (helper (+ i 1) sum))))
  ;(if (and (positive? n)
  ;         (integer? n))
      (helper 1 0)
  ;    #f)
)

; Зад.7
(define (perfect? n)
  (= (divisors-sum n) (* 2 n)))

; Зад.8
(define (prime? n)
  (define sqn (sqrt n)) ; локална дефиниция на константа
  (define (helper i) ; не променяме нищо освен брояча на цикъла
    (cond ((> i sqn) #t) ; заб.: >= не стига като проверка, трябва >
          ((= 0 (remainder n i)) #f)
          (else (helper (+ i 1)))))
  (and (> n 1) (helper 2)))

; Зад.9
(define (increasing? n)
  (cond ((< n 10) #t) ; няма нужда от помощна функция за опашкова рекурсия
        ((< (last-digit n) (last-digit (quotient n 10))) #f)
        (else (increasing? (quotient n 10)))))








  
  