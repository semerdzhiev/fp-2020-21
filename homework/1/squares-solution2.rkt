; accumulate -- the version from the lecture slides
(define (accumulate op term init a next b)  
  (define (loop i)
      (if (<= i b)
          (op (term i) (loop (next i)) )
          init
  ))
  (loop a)
)

(define (squares n)

  ; The #<void> value. If not using R5RS, simply define v to be (void)
  (define v (display "")) 

  ; identity
  (define (id x) x)

  ; increment
  (define (1+ n) (+ 1 n))

  ; Display pre, then display elem n-times and then display post
  (define (display-x elem n pre post)
    (define (op x y) (display elem))
    (display pre)
    (accumulate op id v 1 1+ n)
    (display post)
  )

  ; Displays one line of the figure, using
  ; corner-left and corner-right when printing the
  ; corners of a square
  (define (line i corner-left corner-right)
    (display-x "│ " (- n i) "" "")
    (display-x #\─  (- (* i 4) 3) corner-left corner-right)
    (display-x " │" (- n i) "" "")
    (display #\newline)
  )

  (define (top i)    (line i #\┌ #\┐))
  (define (bottom i) (line i #\└ #\┘))

  (define (loop n f term)
    (define (op i result) (f i))
    (accumulate op term v 1 1+ n)
  )

  (loop n top id)
  (loop n bottom (lambda (i) (+ 1 (- n i))))
)

(squares 10)