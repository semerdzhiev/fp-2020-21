#lang racket

; 1. Намира броя на цифрите на дадено естествено число n.
; Реализирайте я рекурсивно.
(define (count-digits n)
  (if (< n 10)
    1
    (+ 1 (count-digits (quotient n 10)))))

; 2. За дадени цяло число x и естествено число n връща x^n.
; Реализирайте я рекурсивно.
(define (pow x n)
  (if (zero? n)
    1
    (* x (pow x (- n 1)))))

; 3. За дадени числа a и b намира сумата на целите числа в интервала [a,b].
; Приемете че a < b.
; Реализирайте я рекурсивно.
(define (interval-sum a b)
  (if (= a b)
    b
    (+ a (interval-sum (+ a 1) b))))

; 4. Намира броя на цифрите на дадено цяло число n.
; Реализирайте я чрез линейна рекурсия (итерация).
(define (count-digits-i n)
  (define (iter counter number)
    (if (< number 10)
      counter
      (iter (+ counter 1)
            (quotient number 10))))
  (iter 1 (abs n)))

; 5. За дадени числа a и b намира сумата на целите числа в интервала [a,b].
; Трябва да работи и за a > b.
; Реализирайте я чрез линейна рекурсия (итерация).
(define (interval-sum-i a b)
  (define (iter i j acc)
    (if (= i j)
      (+ acc i)
      (iter (+ i 1)
            j
            (+ acc i))))
  (if (< a b)
    (iter a b 0)
    (iter b a 0)))

; 6. За дадено цяло число n връща число, чийто цифри са в обратен ред.
; Реализирайте го чрез линейна рекурсия (итерация).
(define (reverse-digits-i n)
  (define (iter number result)
    (if (zero? number)
      result
      (iter (quotient number 10)
            (+ (* result 10)
               (remainder number 10)))))
  (iter n 0))

; 7. За дадени цели числа x и n връща x^n.
; Реализирайте я чрез линейна рекурсия (итерация).
(define (pow-i x n)
  (define (iter step accumulator)
    (if (zero? step)
      accumulator
      (iter (- step 1)
            (* accumulator x))))
  (if (negative? n)
    (/ 1 (iter (- n) 1))
    (iter n 1)))

; 8. За дадени цели числа x и n връща x^n. Но се възползва от свойството:
; ако n е четно, то x^n = (x^(n/2))^2. Реализирайте я чрез линейна рекурсия (итерация).
(define (fast-pow x n)
  (define (iter base exponent accumulator)
    (cond [(zero? exponent) accumulator]
          [(even? exponent)
           (iter (* base base)
                 (/ exponent 2)
                 accumulator)]
          [else (iter base
                      (- exponent 1)
                      (* accumulator base))]))
  (if (negative? n)
      (/ 1 (iter x (- n) 1))
      (iter x n 1)))
