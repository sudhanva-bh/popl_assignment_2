#lang racket/base

(define (my-length lst)
  (let loop ((lst lst) (count 0))
    (if (null? lst)
        count
        (loop (cdr lst) (+ count 1)))))
