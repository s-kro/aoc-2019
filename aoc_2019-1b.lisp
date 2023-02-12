#! /usr/bin/clisp

(defun aoc_2019-1b ()
  (let ((in (open "aoc_2019-1.dat" :if-does-not-exist nil)))
    (let ((x 0))
      (when in
	(loop for line = (read-line in nil)
              while line do (let ((y (parse-integer line)))
			      (loop while (> y 5) do (setf y (- (floor(/ y 3)) 2))						     
						     (format t "y: ~a~%" y)
						     (setf x (+ x y))
						     (format t "x: ~a.~%" x)))
			    (format t "~%")
	      ))))
  (close in))
(aoc_2019-1b)
