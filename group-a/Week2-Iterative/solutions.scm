#lang r5rs

(define (++ n)
  (+ n 1))

(define (% x y)
  (modulo x y))

(define (// x y)
  (quotient x y))

(define (divides? a b)
  (= 0 (modulo b a)))

(define (get-last-digit n)
  (% n 10)
  )

(define (drop-last-digit n)
  (// n 10)
  )

;; Задача 1
(define (reverse-int n)

  (define (loop i result)
    (if (= i 0)
        result
        (loop (drop-last-digit i)
              (+ (get-last-digit i)
                 (* 10 result))))
    )
  (loop n 0)
  )

;; Задача 2
(define (palindrome? n)
  (= n (reverse-int n))
  )

;; Задача 3
(define (divisor-sum n)
  (define (loop i sum)
    (define (next-sum)
      (if (divides? i n)
          (+ sum i)
          sum)
      )

    (if (> i n)
        sum
        (loop (++ i) (next-sum)))
    )

  (loop 1 0))

;; Задача 4
(define (perfect? n)
  (define sum (- (divisor-sum n) n))
  (= n sum)
  )


;; Задача 5
(define (prime? n)
  (define (loop i)
    (define i^2 (* i i))
    (cond
      ((> i^2 n) #t)
      ((divides? i n) #f)
      (else (loop (++ i))))
    )

  (if (= n 1)
      #f
      (loop 2))
  )

;; Задача 6
(define (increasing? n)
  (define (loop num prev-last-digit)
    (define current-last-digit (get-last-digit num))

    (cond
      ((= num 0) #t)
      ((> current-last-digit prev-last-digit) #f)
      (else (loop (drop-last-digit num)
                  current-last-digit)))
    )

  (loop n 10)
 )

;; Задача 7
(define (toBinary n)
  (define (get-last-bin-digit n) (% n 2))

  (define (drop-last-bin-digit n) (// n 2))

  (define (loop num mult bin)
    (if (= num 0)
        bin
        (loop (drop-last-bin-digit num)
              (* 10 mult)
              (+ bin
                 (* mult (get-last-bin-digit num)))))
    )

  (loop n 1 0)
 )


;; Задача 8
(define (toDecimal n)
  (define (loop bin mult dec)
    (if (= bin 0)
        dec
        (loop (drop-last-digit bin)
              (* 2 mult)
              (+ dec
                 (* mult (get-last-digit bin)))))
    )

  (loop n 1 0)
  )
