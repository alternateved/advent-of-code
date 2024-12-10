(defpackage :aoc-2015-02
  (:use :cl))

(in-package :aoc-2015-02)

(defvar *input* (uiop:read-file-lines "../resources/input02"))

(defun parse-dimensions (dimensions)
  (cl-ppcre:register-groups-bind ((#'parse-integer l w h))
      ("(\\d+)x(\\d+)x(\\d+)" dimensions)
    (list l w h)))

(defun calculate-paper (dimensions)
  (destructuring-bind (l w h) dimensions
    (let ((a (* l w))
          (b (* w h))
          (c (* h l)))
      (+ (* 2 a) (* 2 b) (* 2 c) (min a b c)))))

(defun calculate-ribbon (dimensions)
  (let* ((sides (sort dimensions #'<))
         (a (first sides))
         (b (second sides))
         (c (third sides)))
    (+ a a b b (* a b c))))

(defun part-1 (input)
  (reduce #'+
          (mapcar (lambda (d)
                    (calculate-paper
                     (parse-dimensions d)))
                  input)))

(defun part-2 (input)
  (reduce #'+
          (mapcar (lambda (d)
                    (calculate-ribbon
                     (parse-dimensions d)))
                  input)))



