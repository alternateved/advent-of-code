(defpackage :aoc-2015-05
  (:use :cl))

(in-package :aoc-2015-05)

(defvar *input* (uiop:read-file-lines "../resources/input05"))

(defun part-1 (input)
  (count-if 
   (lambda (line)
     (and (>= (cl-ppcre:count-matches "[aeiou]" line) 3)
          (plusp (cl-ppcre:count-matches "([a-z])\\1" line))
          (zerop (cl-ppcre:count-matches "ab\|cd\|pq\|xy" line))))
   input))

(defun part-2 (input)
  (count-if 
   (lambda (line)
     (and (plusp (cl-ppcre:count-matches "([a-z][a-z]).*\\1" line))
          (plusp (cl-ppcre:count-matches "([a-z])[a-z]\\1" line))))
   input))
