(defpackage :aoc-2016-02
  (:use :cl :alexandria))

(in-package :aoc-2016-02)

(defvar *input* (uiop:read-file-lines "../resources/input02"))

(defun add-pairs (&rest pairs)
  (apply #'mapcar #'+ pairs))

(defun nth-nth (l x y)
  (when (and (>= x 0) (>= y 0))
    (nth x (nth y l))))

(defun direction (c)
  (case c
    (#\U '(0 -1))
    (#\R '(1 0))
    (#\D '(0 1))
    (#\L '(-1 0))))

(defun find-digit (ins start grid)
  (destructuring-bind (x y) start
    (loop with pos = start
          with code = (nth-nth grid x y)
          for c across ins
          for dir = (direction c)
          for (dx dy) = (add-pairs pos dir)
          do (when-let ((digit (nth-nth grid dx dy)))
               (setf pos (list dx dy))
               (setf code digit))
          finally (return (list code pos)))))

(defun find-code (input start grid)
  (loop for ins in input
        for (code pos) = (find-digit ins start grid) then (find-digit ins pos grid)
        collect code))

(defun part-1 (input)
  (let ((grid '((1 2 3)
                (4 5 6)
                (7 8 9))))
    (format nil "~{~d~}" (find-code input '(1 1) grid))))

(defun part-2 (input)
  (let ((grid '((nil nil 1 nil nil)
                (nil 2 3 4 nil)
                (5 6 7 8 9)
                (nil A B C nil)
                (nil nil D nil nil))))
    (format nil "~{~d~}" (find-code input '(0 2) grid))))
