#lang racket

(require racket/file
         racket/port
         racket/path
         racket/system)

;; Run from the repository root: racket tests/s1.rkt code/62_q3.rkt
;; Test restrictions do not apply to this separate test harness.

(define args (current-command-line-arguments))
(unless (= (vector-length args) 1)
  (eprintf "Usage: racket tests/s1.rkt <solution.rkt>\n")
  (exit 2))

(define solution (simplify-path (path->complete-path (vector-ref args 0))))
(unless (file-exists? solution)
  (eprintf "Solution file not found: ~a\n" solution)
  (exit 2))

(define racket-exe (find-executable-path "racket"))
(unless racket-exe
  (eprintf "Cannot find the racket executable.\n")
  (exit 2))

(define source (file->string solution))

(define (run-file path)
  (define-values (proc stdout stdin stderr)
    (subprocess #f #f #f racket-exe (path->string path)))
  (close-output-port stdin)
  (define out (port->string stdout))
  (define err (port->string stderr))
  (close-input-port stdout)
  (close-input-port stderr)
  (subprocess-wait proc)
  (values (subprocess-status proc) out err))

;; Put the temporary file beside the solution to preserve relative paths.
(define (run-appended expression)
  (define tmp
    (make-temporary-file
     (path->string (build-path (path-only solution) "s1-test-~a.rkt"))))
  (dynamic-wind
    void
    (lambda ()
      (call-with-output-file tmp #:exists 'truncate
        (lambda (out)
          (display source out)
          (newline out)
          (display expression out)
          (newline out)))
      (run-file tmp))
    (lambda () (when (file-exists? tmp) (delete-file tmp)))))

(define passed 0)
(define failed 0)

(define (check label status actual stderr expected)
  (if (and (equal? status 0)
           (string=? actual expected)
           (string=? stderr ""))
      (begin
        (set! passed (add1 passed))
        (printf "PASS ~a\n" label))
      (begin
        (set! failed (add1 failed))
        (printf "FAIL ~a\n  exit: ~a\n  expected stdout: ~s\n  actual stdout:   ~s\n  stderr:          ~s\n"
                label status expected actual stderr))))

;; The original submission must load without output or errors.
(let-values ([(status out err) (run-file solution)])
  (check "original loads silently" status out err ""))

;; Each entry: name, tree, inorder, preorder, postorder, (height leaves).
(define cases
  (list
   (list "balanced t1"
         '(4 (2 (1 () ()) (3 () ())) (6 (5 () ()) (7 () ())))
         '(1 2 3 4 5 6 7) '(4 2 1 3 6 5 7) '(1 3 2 5 7 6 4) '(3 4))
   (list "right-skewed t2"
         '(1 () (2 () (3 () ())))
         '(1 2 3) '(1 2 3) '(3 2 1) '(3 1))
   (list "symbols t3"
         '(a (b () ()) (c () ()))
         '(b a c) '(a b c) '(b c a) '(2 2))
   (list "empty tree"
         '()
         '() '() '() '(0 0))
   (list "single node"
         '(9 () ())
         '(9) '(9) '(9) '(1 1))
   (list "uneven tree"
         '(8 (3 (1 () ()) (6 (4 () ()) ())) (10 () (14 (13 () ()) ())))
         '(1 3 4 6 8 10 13 14)
         '(8 3 1 6 4 10 14 13)
         '(1 4 6 3 13 14 10 8)
         '(4 3))))

(for ([test cases])
  (define name (list-ref test 0))
  (define tree (list-ref test 1))
  (define ino (list-ref test 2))
  (define pre (list-ref test 3))
  (define post (list-ref test 4))
  (define stats (list-ref test 5))
  (define functions-and-outputs
    (list (cons 'print-inorder (format "~s\n" ino))
          (cons 'print-all-traversals (format "~s\n~s\n~s\n" ino pre post))
          (cons 'print-height-and-leaves (format "~s\n" stats))))
  (for ([item functions-and-outputs])
    (define fun (car item))
    (define expected (cdr item))
    (define call (format "(~a '~s)" fun tree))
    (define-values (status out err) (run-appended call))
    (check (format "~a / ~a" name fun) status out err expected)))

(printf "\n~a passed, ~a failed\n" passed failed)
(exit (if (zero? failed) 0 1))
