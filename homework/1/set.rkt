; Проверява дали множеството set е празно
(define (set-empty? set) 
  (= set 0)
)

; Проверява дали elem се съдържа в множеството set
(define (set-contains? set elem) 
  (= 1 (remainder (quotient set (expt 2 elem)) 2))
)

; Добавя elem в множеството set
(define (set-add set elem)
  (if (set-contains? set elem)
      set; elem вече е добавен в множеството; няма нужда да правим нищо
      (+ set (expt 2 elem))
  )
)

; Премахва елемент от множество.
(define (set-remove set elem)    
    (if (set-contains? set elem)
        (- set (expt 2 elem))
        set; elem не се съдържа в множеството; няма нужда да правим нищо
  )
)

; Намира размера на множеството set
(define (set-size set) 
  (define (count i s result)
    (if (= 0 s)
        result
        (count (+ i 1) (quotient s 2) (+ result (remainder s 2)))
    )
  )
  (count 0 set 0)
)

; Намира резултата от изпълнението на дадена побитова операция върху числата m и n
;
; Видът на операцията се определя от предиката p?
; Функцията работи по следния начин:
; Битовете в A и B се обхождат паралелно, от от най-младшия, към най-старшия.
; Върху всяка двойка битове се прилага предикатът p?
; Ако той върне истина, съответният бит в резултата ще бъде равен на 1.
; В противен случай битът ще бъде 0.
(define (bitwise-op m n p?)

  (define (loop a b mask result)
    (if (and (= a 0) (= b 0))

        result

        (let* (
               (last-bitA (remainder a 2)) ; последен бит на A
               (last-bitB (remainder b 2)) ; последен бит на B
               (r (if (p? last-bitA last-bitB) (+ mask result) result)) ; използваме p?, за да определим дали да вдигнем съответния бит в резултата
               (nextA (quotient a 2))
               (nextB (quotient b 2))
               (m (* mask 2))
              )
          (loop nextA nextB m r)
        )
     )
  )

  (loop m n 1 0)
)

; Намира обединието на две множества
(define (set-union s1 s2)
  (bitwise-op s1 s2 (lambda (x y) (or (= x 1) (= y 1))))
)

; Намира сечението на две множества
(define (set-intersect s1 s2)
  (bitwise-op s1 s2 (lambda (x y) (and (= x 1) (= y 1))))
)

; Намира разликата s1 \ s2.
(define (set-difference s1 s2)
  (bitwise-op s1 s2 (lambda (x y) (and (= x 1) (= y 0))))
)


; Намира сумата f(e0) + f(e1) + ... f(en)
; за множество с елементи {e0, e1, ... en}
(define (set-sum s f)

  (define (loop i rest result)
    (cond ((= rest 0) ; в множеството няма повече елементи
           result)
          
          ((= (remainder rest 2) 0) ; i не се съдържа в множеството
           (loop (+ i 1) (quotient rest 2) result))
          
          (else ; i се съдържа в множеството
           (loop (+ i 1) (quotient rest 2) (+ result (f i))))
    )
  )

  (loop 0 s 0)
)

; Решава задачата за раницата
(define (knapsack c n w p)

  ; Стойност на елементите в s
  (define (value s) (set-sum s p))

  (define (solve c i) ; решение за капацитет c и използване само на предметите с индекси [i,n)
    (cond ((>= i n) 0) ; няма повече предмети -> празно решение

          ((< c (w i)) ; текущият предмет не се побира -> продължаваме нататък
           (solve c (+ i 1))) 

          (else
           (let* (
                  (sw  (set-add (solve (- c (w i)) (+ i 1)) i)) ; решение с включен текущия елемент
                  (swo (solve c (+ i 1))) ; решение без текущия елемент
                  (vw  (value sw))  ; цена на елементите в sw
                  (vwo (value swo)) ; цена на елементите в swo
                 )
             (cond ((and (= sw 0) (= swo 0)) 0) ; и в двата случая няма решение
                   ((< vw vwo) swo) ; решението, в което предметът не участва е по-добро
                   (else sw) ; предметът участва
             )
            )
          )
    )
  )

  (solve c 0)
)
