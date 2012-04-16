#lang racket
(require "shunting-yard.scm")
(provide (all-defined-out))

(define (factorial n)
  (if (= n 0)
      1
      (* n (factorial (- n 1)))))

(define +pi+ 3.1415926535)

;;; Trig functions! Not yet implemented.

(define (sine x . n)
  (cond ((not (null? n))
         (cond ((< 25 (car n))
                0)
               (else (- (/ (expt x (car n)) (factorial (car n)))
                        (sine x (+ 2 (car n)))))))
        (else (- x (sine x 3)))))

(define (cosine x)
  (if (= x 1)
      0
      (sine (- (/ +pi+ 2) x))))

(define (tangent x)
  (/ (cosine x)
     (sine x)))

(define (cotangent x)
  (/ (sine x)
     (cosine x)))

(define (secant x)
  (/ (cosine x)))

(define (cosecant x)
  (/ (sine x)))

;;; /Trig Functions

;;; xCy not yet implemented

(define (choose x y)
  (/ (expt x y) (factorial y)))
   
(define (char->operator char)
  (cond ((eq? char #\+) +)
        ((eq? char #\-) -)
        ((eq? char #\*) *)
        ((eq? char #\/) /)
        ((eq? char #\%) remainder)
        ((eq? char #\!) factorial)
        ((eq? char #\^) expt)
        ((eq? char #\=) =)
        ((eq? char #\<) <)
        ((eq? char #\>) >)))

; > (shunting-yard (tokenize (string->list "1*2*3*4")))
; '(1 2 #\* 3 #\* 4 #\*)

(define (%postfix-eval eqn stack)
  (cond ((null? eqn) stack)
        ((number? (car eqn))
         (%postfix-eval (cdr eqn) (cons (car eqn) stack)))
        ((operator? (car eqn))
         ;; Factorial takes one argument, while all
         ;; other operators take two arguments.
         (if (not (eq? (car eqn) #\!))
             (%postfix-eval (cdr eqn) (cons ((char->operator (car eqn))
                                             (cadr stack)
                                             (car stack))
                                            (cddr stack)))
             (%postfix-eval (cdr eqn) (cons ((char->operator (car eqn))
                                             (car stack))
                                            (cdr stack)))))
        (else (%postfix-eval (cdr eqn) stack))))
  
(define (postfix-eval eqn)
  (%postfix-eval eqn '()))
