#lang racket/base

(define (inorder tree)
  (define (walk node k)
    (if (null? node)
        (k)
        (walk (cadr node)
              (lambda ()
                (cons (car node)
                      (walk (caddr node) k))))))
  (walk tree (lambda () '())))
