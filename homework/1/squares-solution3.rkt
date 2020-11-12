#lang racket

(define (default) #t)

(define (accumulate op term init first next last)
  (define (helper i)
    (if (> i last)
        init
        (op (term i)
            (helper (next i))))
    )

  (helper first)
  )

(define (accumulate-rev op term init first next last)
  (define (helper i)
    (if (> i last)
        init
        (op (helper (next i))
            (term i)))
    )

  (helper first)
  )



(define (square n)
  (define (no-op a b) (display ""))
  (define (++ i) (+ i 1))
  (define (-- i) (- i 1))
  (define (-1+2* n) (-- (* n 2)))
  (define upleft    #\u250C)
  (define upright   #\u2510)
  (define downleft  #\u2514)
  (define downright #\u2518)
  (define bar       #\u2502)
  (define dash      #\u2500)
  (define (corner up left)
    (if up
        (if left
            upleft
            upright)

        (if left
            downleft
            downright))
    )



  (define (pos-printer row up left)
    (lambda (column)
      (define corner-place (-1+2* row))
      (cond
        ((= column corner-place) (display (corner up left)))
        ((> column corner-place) (display dash))
        ((odd? column) (display bar))
        ((default) (display " "))
        )
      )
    )

  (define (line-printer n up)
    (lambda (row)
      (define half-row-size (-1+2* n))
      (accumulate     no-op (pos-printer row up #t) 0 1 ++ half-row-size)
      (display dash)
      (accumulate-rev no-op (pos-printer row up #f) 0 1 ++ half-row-size)
      (display "\n")
      )
    )

  (accumulate     no-op (line-printer n #t) (void) 1 ++ n)
  (accumulate-rev no-op (line-printer n #f) (void) 1 ++ n)
  )
