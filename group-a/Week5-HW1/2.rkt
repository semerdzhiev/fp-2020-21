#lang racket
;; 9876543210
;; 1111111111
;; 1111110000
;; 0000000111
;; 0000001000


(define (// x y) (quotient x y))

(define (left-shift set n)
  (* set
     (expt 2 n))
  )

(define (right-shift set n)
  (// set
     (expt 2 n))
  )

(define (drop-lower set n)
  (left-shift (right-shift set n) n)
  )

(define (drop-higher-then set n)
  (- set (drop-lower set n))
  )

(define (set-remove set elem)
  (+ (drop-lower       set (+ elem 1))
     (drop-higher-then set elem))
  )

(define (set-add set elem)
  (+ (set-remove set elem)
     (left-shift 1 elem)
     )
  )

(define (set-contains? set elem)
  (= set
     (set-add (set-remove set elem)
              elem))
  )

(define (set-empty? set)
  (= 0 set)
  )

(define (set-size set)
  (define (loop s count)
    (if (set-empty? s)
        count
        (loop (right-shift s 1)
              (+ (drop-higher-then s 1)
                 count)))
    )
  (loop set 0)
  )

(define (set-intersect s1 s2)
  (define (loop set1 set2 num result)
    (cond
      ((set-empty? set1) result)
      ((set-empty? set2) result)
      (else (loop (right-shift set1 1)
                  (right-shift set2 1)
                  (+ num 1)
                  (+ result
                     (left-shift (min (drop-higher-then set1 1)
                                      (drop-higher-then set2 1))
                                 num)
                     )
                  ))
      )
    )
  (loop s1 s2 0 0)
  )

(define the-set #b11111111)
(define a-set #b11001100)

(printf "~b\n" the-set)
(printf "~b\n" a-set)
(printf "~b\n" (set-intersect the-set a-set))
