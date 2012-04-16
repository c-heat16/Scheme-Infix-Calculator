#lang racket
(require "shunting-yard.scm"
         "rd-parser.scm"
         "postfix-evaluator.scm")

(provide calc)

(define (infix-calc eqn)
  (postfix-eval (shunting-yard eqn)))

(define (calc eqn)
  (let ([tokens (tokenize (string->list eqn))])
    (if (parse tokens)
        (infix-calc tokens)
        (display "Error: Malformed equation. Unable to compute.\n"))))

;; Is the character provided a numerical digit?
#;(define (digit-char? char)
    (> 10
       (- (char->integer char) (char->integer #\0))
       (- 1)))

; (define digit-char? char-numeric?)

(define (length lst)
  (if (null? lst)
      0
      (+ 1 (length (cdr lst)))))

(define (parse-nums eqn)
  (cond ((null? eqn)
         '())
        ((digit-char? (car eqn))
         (cons (car eqn) (parse-nums (cdr eqn))))
        (else '())))

(define (tokenize eqn)
  (cond ((null? eqn)
         '())
        ((or (operator? (car eqn))
             (eq? #\( (car eqn))
             (eq? #\) (car eqn)))
         (cons (car eqn) (tokenize (cdr eqn))))
        ((digit-char? (car eqn))
         (cons (string->number (list->string (parse-nums eqn)))
               (tokenize (list-tail eqn (length (parse-nums eqn))))))
        (else (tokenize (cdr eqn)))))
