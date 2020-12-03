#lang racket

(define (assoc-set l k v)
  (if (null? l)
      (list (cons k v))
      (if (equal? (car (car l)) k)
          (cons (cons k v) (cdr l))
          (cons (car l) (assoc-set (cdr l) k v)))))

(define (assoc-get l k)
  (if (null? l)
      #f
      (if (equal? (car (car l)) k)
          (cdr (car l))
          (assoc-get (cdr l) k))))

(define (assoc-set-kv l kv)
  (assoc-set l (car kv) (cdr kv)))

(define (accumulate init op l)  ; foldl
  (if (null? l)
      init
      (op (car l) (accumulate init op (cdr l)))))


(define (accumulate-right init op l)   ; foldr
  (if (null? l)
      init
      (op (accumulate-right init op (cdr l)) (car l))))


(define (assoc-merge l1 l2)
  (accumulate-right l1 assoc-set-kv l2))

(define (assoc-merge2 l1 l2)
  (if (null? l2)
      l1
      (assoc-set (assoc-merge2 l1 (cdr l2)) (car (car l2)) (cdr (car l2)))))

(define (children g x)
  (assoc-get g x))

(define (first-not-false l)
  (if (null? l)
      #f
      (if (equal? (car l) #f)
          (first-not-false (cdr l))
          (car l))))

(define (map f l)
  (if (null? l)
      l
      (cons (f (car l)) (map f (cdr l)))))

(define (fmap f v)
  (if (equal? v #f)
      #f
      (f v)))

(define (path g x y)
  (if (equal? x y)
      (list x)
      (fmap
       (lambda (p) (cons x p))
       (first-not-false (map (lambda (child) (path g child y)) (children g x))))))

(define myg
  (list
   (cons 1 (list 2 3))
   (cons 2 (list 4))
   (cons 3 (list))
   (cons 4 (list))))