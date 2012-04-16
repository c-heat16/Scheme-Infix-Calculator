#lang racket
(require "infix-calc.scm")

;;; end of file

(define operators '("*" "/" "+" "-" ""))

(time
 (for*/list ([o1  (in-list operators)]
             [o2  (in-list operators)]
             [o3  (in-list operators)]
             [o4  (in-list operators)]
             [o5  (in-list operators)]
             [o6  (in-list operators)]
             [o7  (in-list operators)]
             [o8  (in-list operators)]
             [o9  (in-list operators)]
             [expr (in-value
                    (apply string-append
                           (list "1" o1 "2" o2 "3" o3 "4" o4 "5" o5 "6" o6 "7" o7 "8" o8 "9" o9 "10")))]
             #:when (= (first (calc expr)) 2012)
             )
   ;(display expr)
   ;(display " = ")
   ;(display (first (calc expr)))
   ;(newline)
   expr))
