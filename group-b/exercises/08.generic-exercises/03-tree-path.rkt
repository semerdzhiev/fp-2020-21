#lang racket
(require rackunit)
(require rackunit/text-ui)

(define empty-tree '())
(define (make-tree root left right) (list root left right))
(define (make-leaf root) (make-tree root empty-tree empty-tree))

; Искаме да проверим дали съществува път между два върха в дърво

(define (tree-path? tree a b)
  (void)
)

(define example-tree (make-tree 1
                                (make-tree 3 (make-leaf 5) (make-leaf 4))
                                (make-tree 9 (make-tree 15 (make-leaf 10) (make-leaf 8)) (make-leaf 11))))

(define tests
  (test-suite
   "tree-path?"
   (test-case "empty tree" (check-false (tree-path? empty-tree 1 2)))
   (test-case "nonempty tree" (check-true (tree-path? example-tree 3 4)))
   (test-case "nonempty tree with no path" (check-false (tree-path? example-tree 5 10)))
 )
)
                                          
(run-tests tests 'verbose)
   