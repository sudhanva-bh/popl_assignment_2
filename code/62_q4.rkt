#lang racket/base

(define (my-length lst)
  (let loop ((lst lst) (count 0))
    (if (null? lst)
        count
        (loop (cdr lst) (+ count 1)))))

(define (my-map f lst)
  (if (null? lst)
      '()
      (cons (f (car lst))
            (my-map f (cdr lst)))))
