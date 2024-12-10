(defpackage :aoc-2015-01
  (:use :cl))

(in-package :aoc-2015-01)

(defvar *input* (uiop:read-file-string "../resources/input01"))

(defun move-floor (instruction)
  (cond
    ((char= instruction #\() 1)
    ((char= instruction #\)) -1)
    (t 0)))

(defun part-1 (input)
  (loop for char across input
        sum (move-floor char)))

(defun part-2 (input)
  (loop for char across input
        for pos from 1
        sum (move-floor char) into total
        when (= -1 total)
          return pos))
