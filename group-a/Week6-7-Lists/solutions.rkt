#lang racket
(#%require "../list.scm")

;; Задача 1
(define (take n lst)
  (cond
    ((null? lst) '())
    ((= n 0) '())
    (else    (cons (head lst) (take (- n 1)
                                    (tail lst))))
    )
  )


(define (drop n lst)
  (cond
    ((null? lst) '())
    ((= n 0) lst)
    (else  (drop (- n 1)
                 (tail lst))))
  )

;; Задача 2

(define (all? p? lst)
  (cond
    ([null? lst] #t)
    ([p? (head lst)] (all? p? (tail lst)))
    (else #f)
    )
  )

(define (any? p? lst)
  (cond
    ((null? lst) #f)
    ((p? (head lst)) #t)
    (else (any? p? (tail lst))))
  )

;; Задача 3

(define (zip lst1 lst2)
  (if (or (null? lst1)
          (null? lst2))
      '()
      (cons (cons (head lst1)
                  (head lst2))
            (zip (tail lst1)
                 (tail lst2)))
      )
  )

;; Задача 4

(define (zipWith op lst1 lst2)
  (if (or (null? lst1)
          (null? lst2))
      '()
      (cons (op (head lst1)
                (head lst2))
            (zipWith op
                     (tail lst1)
                     (tail lst2)))
      )
  )

;; Задача 5

(define (sorted? lst)
  (define (helper last l)
    (cond
      ((null? l) #t)
      ((> last (head l)) #f)
      (else (helper (head l)
                    (tail l)))
      )
    )

  (if (null? lst)
      #t
      (helper (head lst)
              (tail lst))
      )
  )


;; Задача 6

(define (uniques lst)
  (define (loop left result)
    (cond
      ((null? left) result)
      ((any? (lambda (el) (equal? el (head left)))
             result)
       (loop (tail left) result))
      (else (loop (tail left)
                  (cons (head left)
                        result)))
      )
    )

  (reverse (loop lst '()))
  )

;; Задача 7

(define (insert val lst)
  (cond
    ((null? lst) (list val))
    ((< val (head lst)) (cons val lst))
    (else (cons (head lst)
                (insert val (tail lst))))
    )
  )

;; Задача 8

;; (define (insertion-sort lst)
;;   (define (loop left sorted)
;;     sorted
;;    )
;;   lst
;;   )


;; Задача 10

(define (compose . fns)
  (define (id x) x)
  (define (single-compose f1 f2)
    (lambda (x)
      (f1 (f2 x))
      )
    )

  (foldr single-compose
         id
         fns)
  )


;; Задача 11

(define (group-by f lst)
  (define (add-to-group item groups)
    (cond
      ((null? groups) (list (cons (car item)
                                  (list (cdr item)))))
      ((equal? (car item)
               (caar groups)) (cons (cons (car item)
                                          (cons (tail item)
                                                  (tail (head groups))))
                                    (tail groups)))

      (else (cons (head groups)
                  (add-to-group item (tail groups))))
      )
    )

  (define (collect indexed)
    (foldr add-to-group '() indexed))

  (let*
      ((indexed (zipWith cons
                         (map f lst)
                         lst))
       (grouped (collect indexed))
       )
    indexed
    )
  )


;; Задача 12
(define (zipWith* f . lsts)
  (let*
      ((combined (foldr (lambda (l1 l2) (zipWith cons l1 l2))
                        (map (lambda (x) '()) (car lsts))
                        lsts))
       (ziped (map (lambda (lst) (apply f lst))
                   combined))
       )
    ziped
    )
  )
