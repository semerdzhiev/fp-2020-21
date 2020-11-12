#lang racket/base

(require rackunit rackunit/gui racket/include)

(include "expression.rkt")

(define (expect-correct expr)
  (test-true
    (string-append "Expression '" expr "' should be correct")
    (expr-valid? expr)
  )
)

(define (expect-incorrect expr)
  (test-false
    (string-append "Expression '" expr "' should be incorrect")
    (expr-valid? expr)
  )
)

(define (expect-false-on-incorrect op expr)
  (test-false
    (string-append "Operation should return #f on '" expr "'")
    (op expr)
  )
)

(define (expect-value op expr value)
  (test-equal?
    (string-append "Expecting value of '" (if (number? value) (number->string value) value) "' for expression '" expr "'")
    (op expr)
    value
  )
)

(test/gui

 (test-suite
  "Expression validation"
  (expect-correct   "")
  (expect-correct   "      ")
  (expect-correct   "\t\n \t  ")
  (expect-correct   "5")
  (expect-correct   "5123123")
  (expect-correct   "   5       ")
  (expect-correct   "10+20+30")
  (expect-correct   "10   + 20")
  (expect-incorrect "10 20 + 5")
  (expect-incorrect "++++ 5")
  (expect-incorrect "+++")
 )

 (test-suite
  "remove-whitespace works correctly"

  (test-equal?
   "Expressions without whitespace are left intact"
   (remove-whitespace "123abc")
   "123abc")

 (test-equal?
  "Whitespace is removed"
  (remove-whitespace " \t  123 \t abc \t  ")
  "123abc")

  (test-equal?
  "An all-whitespace expression is processed correctly"
  (remove-whitespace "  \t \n \t  ")
  "")
 )

 (test-suite
  "expr-eval returns #f for incorrect expressions"
  (expect-false-on-incorrect  expr-eval  "10 20 + 5")
  (expect-false-on-incorrect  expr-eval  "++++ 5")
  (expect-false-on-incorrect  expr-eval  "+++")
 )

 (test-suite
  "expr-rp returns #f for incorrect expressions"
  (expect-false-on-incorrect  expr-rp  "10 20 + 5")
  (expect-false-on-incorrect  expr-rp  "++++ 5")
  (expect-false-on-incorrect  expr-rp  "+++")
 )

 (test-suite
  "Valid expressions are evaluated correctly"
  (expect-value  expr-eval  ""             0  ) 
  (expect-value  expr-eval  "   "          0  )       
  (expect-value  expr-eval  "\t\n \t "     0  )          
  (expect-value  expr-eval  "5"            5  )  
  (expect-value  expr-eval  "123"          123)    
  (expect-value  expr-eval  "   5    "     5  )            
  (expect-value  expr-eval  "10  + 20"     30 )
  (expect-value  expr-eval  "1+2*3^2+100"  119)
  (expect-value  expr-eval  "8/4/2"        1)
 )

 (test-suite
  "Valid expressions are transformed to reverse polish notation correctly"
  (expect-value  expr-rp  ""             "")
  (expect-value  expr-rp  "   "          "")
  (expect-value  expr-rp  "\t\n \t "     "")
  (expect-value  expr-rp  "5"            "5")
  (expect-value  expr-rp  "123"          "123")
  (expect-value  expr-rp  "   5    "     "5"  )
  (expect-value  expr-rp  "1+2*3^2+100"  "1,2,3,2^*+,100+")
  (expect-value  expr-rp  "8/4/2"        "8,4/,2/")
 )

)
