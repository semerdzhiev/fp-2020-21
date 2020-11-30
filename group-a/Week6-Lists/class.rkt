#lang racket

(define nil '())

;; '() е списък
;; Ако l е списък (cons x l) е списък

(define p (cons "first" "second"))

(define l '((11 12) (21 22)))

;; map, filter, foldl, foldr



(define (map f l)
  (if (null? l)
      '()
      (cons (f (car l))
            (map f (cdr l))))
  )


(define (filter p? l)
  (cond
    ([null? l] '())
    ([p? (car l)] (cons (car l)
                        (filter p? (cdr l))))
    (else (filter p? (cdr l))))
  )


(define (foldr op init l)
  (if (null? l)
      init
      (op (car l)
          (foldr op init (cdr l)))
      )
  )


(define (foldl op init l)
  (define (loop left result)
    (if (null? left)
        result
        (loop (cdr left)
              (op result (car left)))
        )
    )

  (loop l init)
  )
