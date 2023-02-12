#! /usr/bin/clisp

(defun aoc_2019-1 ()
  (let ((in (open "aoc_2019-1.dat" :if-does-not-exist nil)))
    (let ((x 0))
      (when in
	(loop for line = (read-line in nil)
              while line do ;;(format t "~a Total ~a.~%" line x)
	      while (> y 5) do (let ((y (- (floor(/ (parse-integer line) 3)) 2)))
			    (format t "y: ~a.~%" y)
			  
			  (setf x (+ x y))
			  (format t "x: ~a.~%~%" x))
	      ))))
  (close in))
(aoc_2019-1)
