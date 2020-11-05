#lang racket

(define (accumulate from to op term acc)
  (if (> from to)
    acc
    (accumulate (+ from 1)
                 to
                 op
                 term
                 (op acc (term from)))))

