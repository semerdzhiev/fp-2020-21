#lang racket
(#%require "../common.scm")

;;Задача 1
(define [constantly c]
  (lambda [x] c)
  )

;; Задача 2
(define [flip op]
  (lambda [x y] (op y x))
  )


;; Задача 3
(define [complement p?]
  (lambda [x]
    (not (p? x)))
  )

;; Задача 4
(define [compose f g]
  (lambda [x] (f (g x)))
  )

;; Задача 5
(define [repeat n f]
  (define [loop i rep]
    (if [> i n]
        rep
        (loop (++ i) (compose rep f)))
    )

  (loop 1 (lambda [x] x))
  )

;; Задача 6

(define [derive f]
  (lambda [x]
    ((derive-n 1 f) x)
    )
  )

;; Задача 7
(define [derive-n n f]
  (define [derive-helper f]
    (define dx 1/100000)

    (lambda [x]
      (/ (- (f (+ x dx))
            (f x))
         dx)
      )
    )

  (define [loop i der]
    (if [> i n]
        der
        (loop (++ i) (derive-helper der)))
    )

  (lambda [x]
    ((loop 1 f) x)
    ))
