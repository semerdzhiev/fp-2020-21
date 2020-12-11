#lang racket

(define empty-tree '())
(define (tree-new-node root left right)
  (list root left right)
  )
(define (tree-new-leaf root) (tree-new-node root empty-tree empty-tree))

(define tree-empty? null?)
(define tree-root car)
(define tree-left cadr)
(define tree-right caddr)

(define (tree? tree)
  (cond
    ((not (list? tree)) #f)
    ((null? tree) #t)
    ((not (= (length tree) 3)) #f)
    (else (and (tree? (tree-left  tree))
               (tree? (tree-right tree))))
    )
  )

(define (tree-max-depth tree)
  (if (tree-empty? tree)
      0
      (+ 1 (max (tree-max-depth (tree-left tree))
                (tree-max-depth (tree-right tree))))
   )
  )

(define (tree-balanced? tree)
  (if (tree-empty? tree)
      0
      (let*
          (
           (left-depth (tree-balanced? (tree-left tree)))
           (right-depth (tree-balanced? (tree-right tree)))
           (dep-diff (lambda () (abs (- left-depth
                                        right-depth))))
           (balanced-by-dept (lambda () (if (< (dep-diff) 2)
                                            (+ 1 (max left-depth right-depth))
                                            #f
                                            )
                               ))
           )

        (and left-depth right-depth (balanced-by-dept))
        )
    )
  )

(define (ordered? tree)
  (define (ordered-helper tree min-check? max-check?)
    (cond
      ((tree-empty? tree) #t)
      ((and (min-check? (tree-root tree))
            (max-check? (tree-root tree))) (and (ordered-helper (tree-left tree)
                                                                min-check?
                                                                (lambda (child-root)
                                                                  (<= child-root (tree-root tree)))
                                                                )
                                                (ordered-helper (tree-right tree)
                                                                (lambda (child-root)
                                                                  (>= child-root (tree-root tree)))
                                                                max-check?
                                                                )
                                                )

       )
      (else #f)
      )
    )

  (ordered-helper tree
                  (lambda (x) #t)
                  (lambda (x) #t)
                  )
  )

(define (tree->stream tree)
  (if (tree-empty? tree)
      empty-stream
      (stream-append (tree->stream (tree-left tree))
                     (stream-cons (tree-root tree)
                                  (tree->stream (tree-right tree)))
                     )
      )
  )

(define (tsl tree)
  (stream->list (tree->stream tree))
  )

(define nb-tree
  (tree-new-node 5
                 (tree-new-leaf 1)
                 (tree-new-node 10
                                (tree-new-leaf 6)
                                (tree-new-node 19
                                               (tree-new-leaf 12)
                                               (tree-new-leaf 22)
                                               ))
                 )
  )


(define b-tree
  (tree-new-node 5
                 (tree-new-leaf 1)
                 (tree-new-leaf 10)
                 )
  )
