;;#! /usr/bin/clisp
;;||
;;-quicklisp
;; (let ((quicklisp-init (merge-pathnames "dev/lisp/quicklisp/setup.lisp" (user-homedir-pathname))))
;;   (when (probe-file quicklisp-init)
;;     (load quicklisp-init)))
;; ;;
;;||

(ql:quickload "split-sequence")


(defun compiler (i j x)
  (let ((opcode nil) (ip 0))
    (setf y (copy-seq x))
    (setf (aref y 1) i)
    (setf (aref y 2) j)
    (loop while (/= (aref y ip) 99)
	  do (setf opcode (aref y ip))
	  (let ((a (aref y (aref y (+ ip 1))))
		(b (aref y (aref y (+ ip 2))))
		(c nil))
	    (case opcode
	      (1 (setq c (+ a b)))
	      (2 (setq c (* a b)))
	      (99 return))
	    
	    (setf (aref y (aref y (+ ip 3))) c))
	  (format t "oc: ~a a: ~a b: ~a c: ~a ip: ~a~%" opcode a b c ip))
	  (incf ip 4)))
  (if (eql (aref y 0) 19690720) (format t " noun: ~a verb: ~a alarm: ~a~%" i j (+ j (* i 100))))
  ;(format t " y[0]: ~a~%" (aref y 0))
  )


(defun aoc_2019-2b ()
  (format t " y[0]: test")
  (let ((x (make-array 0 :fill-pointer 0 :adjustable t :element-type 'integer)))
    
    (let ((in (open "aoc_2019-2.dat" :if-does-not-exist nil)))
      (when in
	(loop for line = (read-line in nil)
	      while line
	      do (let ((intcode (split-sequence:SPLIT-SEQUENCE #\, line)))
		   (loop for i in intcode do
			 (setq i (parse-integer i))
			 ;(format t "i: ~a~%" i)
			 (vector-push-extend i x))
		   (format t "~%"))))
      (reverse x)
      (close in))
    ;; (dotimes (i 100)
    ;;   (dotimes (j 100)
    ;; 	(compiler i j x)))
    ))
(aoc_2019-2b)


