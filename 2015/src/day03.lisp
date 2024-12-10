(defpackage :aoc-2015-03
  (:use :cl))

(in-package :aoc-2015-03)

(defvar *input* (uiop:read-file-string "../resources/input03"))

(defun add-pairs (&rest pairs)
  (apply #'mapcar #'+ pairs))

(defun move (m)
  (case m
    (#\^ '(0 -1))
    (#\v '(0 1))
    (#\> '(1 0))
    (#\< '(-1 0))))

(defun part-1 (input)
  (let ((santa '(0 0))
        (houses '((0 0))))
    (loop for m across input
          do (setf santa (add-pairs santa (move m)))
             (push santa houses))
    (length (remove nil (remove-duplicates houses :test #'equal)))))

(defun part-2 (input)
  (let ((santa '(0 0))
        (robo-santa '(0 0))
        (houses '((0 0))))
    (loop with l = (length input)
          for i from 0 below l by 2
          for m = (aref input i)
          for n = (if (< (1+ i) l) (aref input (1+ i)) nil)
          do (setf santa (add-pairs santa (move m)))
             (push santa houses)
             (setf robo-santa (add-pairs robo-santa (move n)))
             (push robo-santa houses))
    (length (remove nil (remove-duplicates houses :test #'equal)))))

