#lang racket

(define [++ n]
  (+ n 1))

(define [id n] n)

(define [otherwise] #t)

;; Реурсивна дясно асоциативна имплементация на `accumulate`.
(define [accumulate operation
                    transform
                    initial
                    start
                    next
                    end]

  (define [helper i]
    (if [> i end]
        initial
        (operation (transform i)
                   (helper (next i))))
    )

  (helper start)
  )

;; Итеративна ляво асоциатиативна имплементация на `accumulate`.
(define [iaccumulate operation
                      transform
                      initial
                      start
                      next
                      end]

  (define [loop i result]
    (if [> i end]
        result
        (loop (next i)
              (operation result (transform i))))
    )

  (loop start initial)
  )

(define [sum-from-1-to n]
  (iaccumulate +
               id
               0
               1
               ++
               n)
  )

(define [sum-square-from-1-to n]
  (iaccumulate +
               (lambda (x) (* x x))
               0
               1
               ++
               n)
  )

(accumulate /
            id
            1
            1
            ++
            3)

;; 1 /(2 / (3 / 1)) =>  1 / (2 / 3) => 3 / 2

(iaccumulate /
             id
             1
             1
             ++
             3)

;; ((1 / 1) / 2) / 3 => (1 / 2) / 3 => 1 / 6
