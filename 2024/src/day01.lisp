(defpackage :aoc/2024/01
  (:use :cl))

(in-package :aoc/2024/01)

(defun separate-sides (lines)
  (loop for line in lines
        for (left right) = (remove "" (uiop:split-string line) :test #'string=)
        collect (parse-integer left) into left-side
        collect (parse-integer right) into right-side
        finally (return (list left-side right-side))))

(defun sort-sides (sides)
  (mapcar (lambda (sublist) (sort (copy-list sublist) #'<)) sides))

(defun zip (lists)
  (apply #'mapcar #'list lists))

(defun sum (numbers)
  (apply #'+ numbers))

(defun process-pair (pair)
  (destructuring-bind (a b) pair
    (abs (- a b))))

(defun calculate-frequencies (sides)
  (destructuring-bind (left-side right-side) sides
    (mapcar (lambda (number)
              (list number (count number right-side)))
            left-side)))

(defvar *input* (uiop:read-file-lines "../resources/input01"))

(defun part-1 (input)
  (sum (mapcar #'process-pair
               (zip (sort-sides (separate-sides input))))))

(defun part-2 (input)
  (sum (mapcar (lambda (pair)
                 (destructuring-bind (a b) pair
                   (* a b)))
               (calculate-frequencies (separate-sides input)))))
