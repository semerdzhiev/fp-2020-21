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


;;;;;;

;; = - сравнява числа
;; eq? - сравнява дали 2 обекта са записнани на едно място в паметта
;; eqv? - работи, като eq?, но работи по специален начин с числа
;; equal? - работи като eqv?, но проверява с eqv? списъци в дълбочина

;; (memq el l) - eq?
;; (memv el l) - eqv?
;; (member el l) - equal?

(define (sum arg1 . args)
  (foldl + arg1 args)
  )

;;;;

;; празно дърво
;;'()
;; rооt - произволен елемент, left-sub-tree и right-sub-tree - дървета
;;'(root left-sub-tree right-subtree)


(define tree::empty '())
(define (tree::new root left right)
  (list root left right)
  )
(define tree::empty? null?)
(define tree::root car)
(define tree::left cadr)
(define tree::right caddr)

(define a-tree '(6 (4 ()
                      (5 ()
                         ()))
                   (12 (7 ()
                          ())
                       (33 (20 (30 () ())
                               ())
                           ())
                       )))


(define (tree::max-depth tree)
  (if (tree::empty? tree)
      0
      (+ 1
         (max (tree::max-depth (tree::left tree))
              (tree::max-depth (tree::right tree)))))
)
