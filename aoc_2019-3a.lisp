#! /usr/bin/clisp

#-quicklisp
 (let ((quicklisp-init (merge-pathnames "dev/lisp/quicklisp/setup.lisp" (user-homedir-pathname))))
   (when (probe-file quicklisp-init)
     (load quicklisp-init)))

(require :asdf)
(ql:update-dist "quicklisp")
(ql:quickload '("cl-ppcre" "split-sequence" "alexandria" "for"))

(defun aoc_2019-3a ()
  (let ((v (make-array 0 :fill-pointer 0 :adjustable t :element-type 'list)))
    (let ((in (open "aoc_2019-3-test.dat" :if-does-not-exist nil)))
      (when in
	(loop for line = (read-line in nil)
	      while line
	      do (let ((path (split-sequence:SPLIT-SEQUENCE #\, line)))
		   (let ((w (make-array 0 :fill-pointer 0 :adjustable t :element-type 'list)))
		     (loop for segment in path do
		       (ppcre:register-groups-bind (direction (#'parse-integer distance))
						   ("(R|L|U|D)(\\d+)" segment)
						   (vector-push-extend (list direction distance) w)))
		     (reverse w)
		     (vector-push-extend w v)
		     (format t "~%")))))
      (close in)
      
      (let ((X2 0) (Y2 0) (md 100000))
	(for:for ((j over (aref v 0)))
		 (let ((DIR2 (nth 0 j)) (DIS2 (nth 1 j)))
		   (let ((X1 0) (Y1 0))
		     (for:for ((i over (aref v 1)))
			      (let ((DIR1 (nth 0 i)) (DIS1 (nth 1 i)))
				(alexandria:switch (DIR1 :test #'equal) 
						   ("U" (if (and (or (and (equal DIR2 "R")
									  (> X1 X2) (< X1 (+ X2 DIS2)))
								     (and (equal DIR2 "L")
									  (< X1 X2) (> X1 (- X2 DIS2))))
								 (and (> Y2 Y1) (< Y2 (+ Y1 DIS1))))
							    (progn (format t "Crossing: X: ~a,~C Y: ~a~%" X1 #\tab Y2)
								   (if (> md (+ (abs X1) (abs Y2)))
								       (progn (setq md (+ (abs X1) (abs Y2)))
									      (format t "New Manhattan Distance: ~a~%" md)))))
							(setq Y1 (+ Y1 DIS1)))
						   ("D" (if (and (or (and (equal DIR2 "R")
									  (> X1 X2) (< X1 (+ X2 DIS2)))
								     (and (equal DIR2 "L")
									  (< X1 X2) (> X1 (- X2 DIS2))))
								 (and (< Y2 Y1) (> Y2 (- Y1 DIS1))))
							    (progn (format t "Crossing: X: ~a,~C Y: ~a~%" X1 #\tab Y2)
								   (if (> md (+ (abs X1) (abs Y2)))
								       (progn (setq md (+ (abs X1) (abs Y2)))
									      (format t "New Manhattan Distance: ~a~%" md)))))
							(setq Y1 (- Y1 DIS1)))
						   ("L" (if (and (or (and (equal DIR2 "U")
									  (> Y1 Y2) (< Y1 (+ Y2 DIS2)))
								     (and (equal DIR2 "D")
									  (< Y1 Y2) (> Y1 (- Y2 DIS2))))
								 (and (< X2 X1) (> X2 (- X1 DIS1))))
							    (progn (format t "Crossing: X: ~a,~C Y: ~a~%" X2 #\tab Y1)
								   (if (> md (+ (abs X2) (abs  Y1)))
								       (progn (setq md (+ (abs X2) (abs Y)))
									      (format t "New Manhattan Distance: ~a~%" md)))))
							(setq X (- X DIS1)))
						   ("R" (if (and (or (and (equal DIR2 "U")
									   (> Y1 Y2) (< Y1 (+ Y2 DIS2)))
								      (and (equal DIR2 "D")
									   (< Y1 Y2) (> Y1 (- Y2 DIS2))))
								  (and (> X2 X1) (< X2 (+ X1 DIS1))))
							     (progn (format t "Crossing: X: ~a,~C Y: ~a~%" X2 #\tab Y1)
								    (if (> md (+ (abs X2) (abs Y1)))
									(progn (setq md (+ (abs X2) (abs Y1)))
									       (format t "New Manhattan Distance: ~a~%" md)))))
							 (setq X1 (+ X1 DIS1)))
						   ))))
		   (alexandria:switch (DIR2 :test #'equal) 
				      ("U" (setq Y2 (+ Y2 DIS2)))
				      ("D" (setq Y2 (- Y2 DIS2)))
				      ("L" (setq X2 (- X2 DIS2)))
				      ("R" (setq X2 (+ X2 DIS2))))
		   )))) ))
(aoc_2019-3a)


