; Проверява дали даден символ е операция
(define (char-op? c)
  (and (char? c)
       (or
        (char=? c #\+)
        (char=? c #\-)
        (char=? c #\*)
        (char=? c #\/)
        (char=? c #\^)
        )
   )
)

; проверява дали expr е валиден израз. Например:
(define (expr-valid? expr)

  (define (number i)
    (cond
      ((>= i (string-length expr))            #t)
      ((char-numeric?    (string-ref expr i)) (number (+ i 1)))
      ((char-op?         (string-ref expr i)) (op (+ i 1)))
      ((char-whitespace? (string-ref expr i)) (whitespace-after-number (+ i 1)))          
      (else                                   #f)
    )
  )
        
  (define (op i)
    (cond
      ((>= i (string-length expr))            #f)
      ((char-numeric?    (string-ref expr i)) (number (+ i 1)))
      ((char-whitespace? (string-ref expr i)) (whitespace-after-op (+ i 1)))          
      (else                                   #f)
    )
  )

  (define (whitespace-after-number i)
    (cond
      ((>= i (string-length expr))            #t)
      ((char-op?         (string-ref expr i)) (op (+ i 1)))
      ((char-whitespace? (string-ref expr i)) (whitespace-after-number (+ i 1)))
      (else                                   #f)
    )
  )

  (define (whitespace-after-op i)
    (cond
      ((>= i (string-length expr))            #f)
      ((char-numeric?    (string-ref expr i)) (number (+ i 1)))
      ((char-whitespace? (string-ref expr i)) (whitespace-after-op (+ i 1)))
      (else                                   #f)
    )
  )

  (define (whitespace-at-start i)
    (cond
      ((>= i (string-length expr))            #t)
      ((char-numeric?    (string-ref expr i)) (number (+ i 1)))
      ((char-whitespace? (string-ref expr i)) (whitespace-at-start (+ i 1)))
      (else                                   #f)
    )
  )

  (cond
    ((= 0 (string-length expr))          #t)
    ((char-numeric? (string-ref expr 0)) (number 0))
    (else                                (whitespace-at-start 0))    
  )
)

; Премахва празните символи (whitespace) от даден израз
(define (remove-whitespace str)
  (define (loop i result)
    (cond
      ((>= i (string-length str)) result)
      
      ((char-whitespace? (string-ref str i)) (loop (+ i 1) result))

      (else (loop (+ i 1) (string-append result (string (string-ref str i)))))
    )
  )
  (loop 0 "")
)

; Връща приоритета на операцията op.
; Функцията връща 0, ако op не е валидна операция
(define (op-precedence op)
  (case op
    ((#\^)     3)
    ((#\* #\/) 2)
    ((#\+ #\-) 1)
  )
)

; Проверява дали приоритетът на операцията op1 е по-малък от този на op2
(define (op<? op1 op2)
  (< (op-precedence op1) (op-precedence op2))
)

; Връща стойността на израза expr. Например:
; (expr-eval "10+20*30") → 610
; (expr-eval "") → 0
; Ако expr е невалиден израз, да се върне #f.
(define (iterate-expr expr process-op process-number empty-value)

  ; Намира операцията с най-висок приоритет в обхвата [l,r) в низа
  (define (lowest-op-position-rtl e l r)

    (define (choose-between i j) 
      (if (op<? (string-ref e i) (string-ref e j)) i j)
    )

    (define (loop i result)
      (cond
        ((< i l) result)
        ((not (char-op? (string-ref e i))) (loop (- i 1) result))
        ((not (number? result))            (loop (- i 1) i))
        (else                              (loop (- i 1) (choose-between i result)))
      )
    )

    (loop (- r 1) #f)
  )

  ; Обработва подниза в обхвата [l, r)
  (define (process e l r)
    (let (
          (i (lowest-op-position-rtl e l r))
         )
      (if (number? i)
          (process-op (string-ref e i)
                      (process e l i)
                      (process e (+ i 1) r))
          (process-number (substring e l r))
      )
    )
  )

  (if (expr-valid? expr)
      (let ((e (remove-whitespace expr)))
        (if (= 0 (string-length e))
            empty-value
            (process e 0 (string-length e))
        )
      )
      #f
  )
)


; връща представянето на expr в обратен полски запис.
; Ако expr е невалиден израз, да се върне #f.
; За разделител между аргументите да се използва запетая.
(define (expr-rp expr)

  (define (number str) str)

  (define (op code arg1 arg2)
    (string-append arg1 "," arg2 (string code))
  )

  (iterate-expr expr op number "")
)


(define (expr-eval expr)

  (define (number str)
    (string->number str)
  )

  (define (op code arg1 arg2)
    (case code
      ((#\^) (expt arg1 arg2))
      ((#\*) (* arg1 arg2))
      ((#\/) (/ arg1 arg2))
      ((#\+) (+ arg1 arg2))
      ((#\-) (- arg1 arg2))
    )
  )

  (iterate-expr expr op number 0)
)


