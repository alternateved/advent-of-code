(defpackage :aoc-2016-03
  (:use :cl))

(in-package :aoc-2016-03)

(defvar *input* (uiop:read-file-lines "../resources/input03"))

(defun parse-sides (sides)
  (cl-ppcre:register-groups-bind ((#'parse-integer a b c))
      ("\\s*(\\d+)\\s*(\\d+)\\s*(\\d+)" sides)
    (list a b c)))

(defun valid-triangle-p (sides)
  (destructuring-bind (a b c) sides
    (and (plusp a)
         (plusp b)
         (plusp c)
         (> (+ a b) c)
         (> (+ a c) b)
         (> (+ b c) a))))

(defun part-1 (input)
  (loop for s in (mapcar #'parse-sides input)
        when (valid-triangle-p s)
          count it))

(defun part-2 (input)
  (loop with sides = (mapcar #'parse-sides input)
        for ((a1 a2 a3) (b1 b2 b3) (c1 c2 c3)) on sides by #'cdddr
        when (valid-triangle-p (list a1 b1 c1))
          count it
        when (valid-triangle-p (list a2 b2 c2))
          count it
        when (valid-triangle-p (list a3 b3 c3))
          count it))
