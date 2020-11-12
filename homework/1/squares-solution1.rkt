; accumulate -- the version from the lecture slides
(define (accumulate op term init a next b)  
  (define (loop i)
      (if (<= i b)
          (op (term i) (loop (next i)) )
          init
  ))
  (loop a)
)

; The #<void> value. If not using R5RS, simply define v to be (void)
(define v (display "")) 

; identity function
(define (id x) x)

; adds 1 to its argument
(define (1+ n) (+ 1 n))

; Calls the procedure f n-times
; We assume f receives on arguments
(define (loop-proc n f)
  (define (op i result) (f))
  (accumulate op id v 1 1+ n)
)

; Calls the function f n-times consecutively
; passing 1, 2, ... n as its arguments
(define (loop-onearg n f)
  (define (op i result) (f i))
  (accumulate op id v 1 1+ n)
)

; prints a line of dashes
(define (line n)
  (loop-proc n (lambda () (display #\─)))
)

; prints one side (top or bottom) of a square
(define (side n l r)
  (display l)
  (line (- n 2))
  (display r)
)

(define (top n) (side n #\┌ #\┐))
(define (bottom n) (side n #\└ #\┘))

(define (spaced c n)
  (loop-proc n (lambda () (begin (display c) (display " "))))
)

(define (verticals n) (spaced #\│ n))

(define (squares n)

  (define (nl) (display #\newline))

  (define (top-line i)
    (verticals (- n i))
    (top (- (* i 4) 1))
    (display #\space)
    (verticals (- n i))
    (nl)
  )

  (define (bottom-line i)
    (verticals (- i 1))
    (bottom (+ (* (- n i) 4) 3))
    (display #\space)
    (verticals (- i 1))
    (nl)
  )

  (loop-onearg n top-line)
  (loop-onearg n bottom-line)
)

(display "Printing zero squares:\n")
(squares 0)
(display "Printing ten squares:\n")
(squares 10)