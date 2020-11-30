#lang racket

;; (define slavi-info '(
;;                      (age 28)
;;                      (name "Slavi Boyanov")
;;                      (age 27)
;;                      (birth-place "Pernik")
;;                      )
;;   )

(define (make-multiset . values)
  (define (ctor . props) ;;props == '() => празно дърво, props == '(value left right)
    (define empty (null? props))
    (define (value) (car props))
    (define (left)  (cadr props))
    (define (right) (caddr props))

    (define (self method . args)
      (case method
        ('empty empty)


        ('value (if empty (void) (value)))
        ('left (if empty (void) (left)))
        ('right (if empty (void) (right)))

        ('smallest (cond
                     (empty (void))
                     (((left) 'empty) (value))
                     (else ((left) 'smallest))
                     ))

        ('contains (let
                       ((elem (car args)))
                     (cond
                       (empty #f)
                       ((= (value) elem) #t)
                       ((< (value) elem) ((right) 'contains elem))
                       (else ((left) 'contains elem))
                       )
                     ))

        ('add (let
                  ((to-add (car args)))
                (cond
                  (empty (ctor to-add (ctor) (ctor)))
                  ((< (value) to-add) (ctor (value)
                                            (left)
                                            ((right) 'add to-add)))
                  (else (ctor (value)
                              ((left) 'add to-add)
                              (right)))
                  )
                ))

        ('remove (let
                     ((to-remove (car args)))
                   (cond
                     (empty self)
                     ((< (value) to-remove) (ctor (value)
                                                  (left)
                                                  ((right) 'remove to-remove)))

                     ((> (value) to-remove) (ctor (value)
                                                  ((left) 'remove to-remove)
                                                  (right)))
                     (else (if ((right) 'empty)
                               (left)
                               (let
                                   ((smallest-right ((right) 'smallest)))

                                 (ctor smallest-right
                                       (left)
                                       ((right) 'remove smallest-right))
                                 ))
                           )
                     )))

        ('foldl-inorder (let
                            ((operation (car args))
                             (term (cadr args))
                             (init (caddr args)))
                          (define (walk tree result)
                            (if (tree 'empty)
                                result
                                (let*
                                    ((left-result (walk (tree 'left) result))
                                     (in-result (operation left-result
                                                           (term (tree 'value))))
                                     (walk-result (walk (tree 'right) in-result)))

                                  walk-result)
                                )
                            )

                          (walk self init)
                         ))

        ('as-list (if empty
                      '()
                      (list (value) ((left) 'as-list) ((right) 'as-list))
                      ))


        ('print (self 'foldl-inorder
                      (lambda (x y) (void))
                      (lambda (x) (display x) (display " "))
                      (void)
                      ))

        (else (error "Missing method called" method))
        )
      )

    self
    )

  (define (construct values mset)
    (if (null? values)
        mset
        (construct (cdr values) (mset 'add (car values)))
        )
    )
  (construct values (ctor))
  )

(define (make-set . values)
  (define (ctor super)
    (define (self method . args)
      (define (call-super)
        (apply super (cons method args))
        )

      (define (intersept-change)
        (ctor (call-super))
        )

      (case method
        ('add (let
                  ((to-add (car args)))
                (if (super 'contains to-add)
                    self
                    (ctor (super 'add to-add))
                    )
                ))

        ((remove) (intersept-change))

        (else (call-super)))
        )

    self
    )

  (define (construct values set)
    (if (null? values)
        set
        (construct (cdr values) (set 'add (car values)))
        )
    )

  (construct values (ctor (make-multiset)))
  )

(define lost-nums (make-set 4 8 15 16 23 42))

(begin
  (lost-nums 'print) ;; 4 8 15 16 23 42
  (lost-nums 'add 7) ;; Adding 7
  (lost-nums 'print) ;; lost-nums не е променено пак принтира 4 8 15 16 23 42
  ((lost-nums 'add 7) 'print) ;; 4 7 8 15 16 23 42
  ((lost-nums 'add 4) 'print) ;; 4 8 15 16 23 42
  ((lost-nums 'remove 8) 'print) ;; 4 15 16 23 42
  ((lost-nums 'remove 7) 'print) ;; 4 8 15 16 23 42
  (display (lost-nums 'contains 4)) ;; #t
  (display (lost-nums 'contains 5)) ;; #f
  ((lost-nums 'remove 7) 'print) ;; 4 8 15 16 23 42
  )
