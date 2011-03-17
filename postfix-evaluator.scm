


(set! %load-path (cons "/home/andy/Dropbox/Programming/Scheme" %load-path))

(for-each (lambda (file)
            (load-from-path file))
          '("shunting-yard.scm"))

(define (factorial n)
  (if (= n 0)
      1
      (* n (factorial (- n 1)))))

(define (char->operator char)
  (cond ((eq? char #\+) '+)
        ((eq? char #\-) '-)
        ((eq? char #\*) '*)
        ((eq? char #\/) '/)
        ((eq? char #\!) 'factorial)
        ((eq? char #\^) 'expt)
        ((eq? char #\=) '=)
        ((eq? char #\<) '<)
        ((eq? char #\>) '>)))

(define (%postfix-eval eqn stack)
  (cond ((null? eqn) stack)
        ((digit-char? (car eqn))
         (%postfix-eval (cdr eqn) (cons (- (char->integer (car eqn)) 48) stack)))
        ((operator? (car eqn))
         (%postfix-eval (cdr eqn) (cons (eval
                                         `(,(char->operator (car eqn))
                                           ,(cadr stack)
                                           ,(car stack))
                                         (interaction-environment))
                                        (cddr stack))))
        (else (%postfix-eval (cdr eqn) stack))))
  
(define (postfix-eval eqn)
  (%postfix-eval eqn '()))