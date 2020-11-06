#lang racket
(require rackunit)
(require rackunit/text-ui)

; Ще сортираме списък по метода на пряката селекция.
; За тази цел започваме с дефиниции на спомагателни функции.

; remove-first - връща ни xs, но без първото срещане на x
(define (remove-first x xs)
  (cond ((null? xs) '())
        ((= x (car xs)) (cdr xs))
        (else (cons (car xs) (remove-first x (cdr xs))))))


; find-min - връща ни най-малкото число от непразен списък
(define (find-min xs)
  (cond ((null? (cdr xs)) (car xs))
        (else (min (car xs) (find-min (cdr xs))))))


(define (selection-sort xs)
  (if (null? xs)
      '()
      (else
        (let ((min-element (find-min xs)))
             (cons min-element (selection-sort (remove-first min-element xs)))))))

(define tests
  (test-suite "Selection sort"
    ; Искаме да тестваме тази функция
  )
)

(run-tests tests 'verbose)
