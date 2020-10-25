#lang r5rs

;; Функция която виръща константно истина.
;; Използвана при `cond` за прегледност
(define (otherwise) #t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Реурсивни имплементации на `accumulate`. ;;
;; Всички са дясно асоциативни.             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (accumulate operation ;; Прилагана операция на всяка стъпка.
                    transform ;; Трансформация прилагана върху "брояча".
                    initial   ;; Стойност използвана за дясната част на
                              ;;  най-върешното прилагане на операцията.
                    start     ;; Начална стойност на "брояча".
                    next      ;; Функция за намиране на следващата стойност
                              ;;  на "брояча"
                    end)      ;; Най-голямата стойност която може да приеме "брояча"

  (define (helper i)
    (if (> i end)
        initial
        (operation (transform i)
                   (helper (next i))))
    )

  (helper start)
  )

(define (filter-accumulate should-process? ;; Предикат указващ, кои стойности на
                                           ;; "брояча" са от значение за пресмятането.
                           operation
                           transform
                           initial
                           start
                           next
                           end)

  (define (helper i)
    (cond
      ((> i end) initial)
      ((should-process? i) (operation (transform i)
                                      (helper (next i))))
      ((otherwise) (helper (next i))))
    )

  (helper start)
  )


(define (accumulate-condition operation
                              transform
                              initial
                              start
                              next
                              should-stop?) ;; Предикат указващ, кога трябва да
                                            ;; се прекрати итерирането.

  (define (helper i)
    (if (should-stop? i)
        initial
        (operation (transform i)
                   (helper (next i))))
    )

  (helper start)
  )

(define (filter-accumulate-condition should-process?
                                     operation
                                     transform
                                     initial
                                     start
                                     next
                                     should-stop?)

  (define (helper i)
    (cond
      ((should-stop? i) initial)
      ((should-process? i) (operation (transform i)
                                      (helper (next i))))
      ((otherwise) (helper (next i))))
    )

  (helper start)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Итеративни имплементации на `accumulate`. ;;
;; Всички са ляво асоциативни.               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (iaccumulate operation ;; Прилагана операция на всяка стъпка.
                     transform ;; Трансформация прилагана върху "брояча".
                     initial   ;; Стойност използвана за дясната част на
                     ;;  най-върешното прилагане на операцията.
                     start     ;; Начална стойност на "брояча".
                     next      ;; Функция за намиране на следващата стойност
                     ;;  на "брояча"
                     end)      ;; Най-голямата стойност която може да приеме "брояча"

  (define (loop i result)
    (if (> i end)
        result
        (loop (next i)
              (operation result
                         (transform i))))
    )

  (loop start initial)
  )

(define (filter-iaccumulate should-process?
                            operation
                            transform
                            initial
                            start
                            next
                            end)

  (define (loop i result)
    (cond
      ((> i end) result)
      ((should-process? i) (loop (next i)
                                 (operation result (transform i))))
      ((otherwise) (loop (next i) result)))
    )

  (loop start initial)
  )

(define (iaccumulate-condition operation
                              transform
                              initial
                              start
                              next
                              should-stop?)

  (define (loop i result)
    (if (should-stop? i)
        result
        (loop (next i)
              (operation result
                         (transform i))))
    )

  (loop start initial)
  )

(define (filter-iaccumulate-condition should-process?
                                      operation
                                      transform
                                      initial
                                      start
                                      next
                                      should-stop?)

  (define (loop i result)
    (cond
      ((should-stop? i) result)
      ((should-process? i) (loop (next i)
                                 (operation result (transform i))))
      ((otherwise) (loop (next i) result)))
    )

  (loop start initial)
  )
