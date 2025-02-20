(defpackage :aoc-2016-06
  (:use :cl))

(in-package :aoc-2016-06)

(defvar *input* (uiop:read-file-lines "../resources/input06"))

(defun string-to-list (string)
  (coerce string 'list))

(defun transpose (list)
  (apply #'mapcar #'list list))

(defun frequencies (part)
  (let ((freq (make-hash-table)))
    (loop for c in part
          do (incf (gethash c freq 0)))
    freq))

(defun max-frequency (ft)
  (let ((max-char nil)
        (max-frequency 0))
    (maphash (lambda (c f)
               (when (> f max-frequency)
                 (setf max-char c
                       max-frequency f)))
             ft)
    max-char))

(defun min-frequency (ft)
  (let ((min-char nil)
        (min-frequency most-positive-fixnum))
    (maphash (lambda (c f)
               (when (< f min-frequency)
                 (setf min-char c
                       min-frequency f)))
             ft)
    min-char))

(defun get-message (f input)
  (format nil "~{~a~}"
          (loop for part in input
                collect (funcall f (frequencies part)))))

(defun prepare-input (input)
  (transpose (mapcar #'string-to-list input)))

(defun part-1 (input)
  (get-message #'max-frequency (prepare-input input)))

(defun part-2 (input)
  (get-message #'min-frequency (prepare-input input)))
