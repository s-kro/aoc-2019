#! /usr/bin/clisp
;;||
;;-quicklisp
(let ((quicklisp-init (merge-pathnames "dev/lisp/setup.lisp" (user-homedir-pathname))))
  (when (probe-file quicklisp-init)
    (load quicklisp-init)))
;;||

(ql:quickload "split-sequence")

(defun aoc_2019-2a ()
  
  (let ((x (make-array 0 :fill-pointer 0 :adjustable t :element-type 'integer)))
    
    (let ((in (open "aoc_2019-2.dat" :if-does-not-exist nil)))
      (when in
	(loop for line = (read-line in nil)
	      while line
	      do (let ((intcode (split-sequence:SPLIT-SEQUENCE #\, line)))
		   (loop for i in intcode do
		     (setq i (parse-integer i))
		     ;;(format t "i: ~a~%" i)
		     (vector-push-extend i x))
		   (format t "~%"))))
      (reverse x)
      (close in))
    (let ((opcode nil) (ip 0))
      (loop while (/= (aref x ip) 99)
	    do (setf opcode (aref x ip))
	       (let ((a (aref x (aref x (+ ip 1))))
		     (b (aref x (aref x (+ ip 2))))
		     (c nil))
		 (case opcode
		   (1 (setq c (+ a b)))
		   (2 (setq c (* a b)))
		   (99 return))
		 
		 (setf (aref x (aref x (+ ip 3))) c))
	       ;;(format t "oc: ~a a: ~a b: ~a c: ~a ip: ~a~%" opcode a b c ip))
	       (incf ip 4)))
    (format t " x[0]: ~a~%" (aref x 0))))
(aoc_2019-2a)
