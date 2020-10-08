#lang racket

(provide (all-defined-out))


(define (all-equal? xs)
  (cond ((null? xs) #t)
        ((null? (cdr xs)) #t)
        (else (and (= (car xs)
                      (cadr xs))
                   (all-equal? (cdr xs))))))

(define (permute xs)
  (if (= (length xs) 1)
    (list xs)
    (apply
      append
        (map (lambda (element)
           (map (lambda (x) (cons element x))
               (permute (remove element xs))))
        xs)
    )
  )
)

