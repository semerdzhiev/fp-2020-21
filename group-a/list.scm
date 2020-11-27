#lang racket
(#%provide (all-defined))

(define head car)
(define tail cdr)

(define (map f l)
  (if (null? l)
      '()
      (cons (f (head l))
            (map f (tail l))))
  )


(define (filter p? l)
  (cond
    ((null? l) '())
    ((p? (head l)) (cons (head l)
                         (filter p? (tail l))))
    (else (filter p? (tail l))))
  )


(define (foldr op init l)
  (if (null? l)
      init
      (op (head l)
          (foldr op init (tail l)))
      )
  )


(define (foldl op init l)
  (define (loop left result)
    (if (null? left)
        result
        (loop (tail left)
              (op result (head left)))
        )
    )

  (loop l init)
  )
