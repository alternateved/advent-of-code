(defpackage :aoc-2024-03
  (:use :cl))

(in-package :aoc-2024-03)

(defvar *input* (uiop:read-file-string "../resources/input03"))

(defun extract-instructions (input)
  (cl-ppcre:all-matches-as-strings
   "mul\\(\\d{1,3},\\d{1,3}\\)" input))

(defun extract-instructions-with-statements (input)
  (cl-ppcre:all-matches-as-strings
   "mul\\(\\d{1,3},\\d{1,3}\\)|do\\(\\)|don't\\(\\)" input))

(defun parse-instruction (ins)
  (cl-ppcre:register-groups-bind ((#'parse-integer n m))
      ("(\\d{1,3}),(\\d{1,3})" ins)
    (list n m)))

(defun parse-instruction-or-statement (ins)
  (cond ((string= ins "do()") t)
        ((string= ins "don't()") nil)
        (t (parse-instruction ins))))

(defun multiply-pair (pair)
  (destructuring-bind (a b) pair
    (* a b)))

(defun apply-instructions (instructions)
  (loop with enabled = t
        for i in instructions
        if (eq i t)
          do (setf enabled t)
        else if (eq i nil)
               do (setf enabled nil)
        else when enabled
               sum (multiply-pair i)))

(defun part-1 (input)
  (reduce #'+ (mapcar #'multiply-pair 
                      (mapcar #'parse-instruction 
                              (extract-instructions input)))))

(defun part-2 (input)
  (apply-instructions
   (mapcar #'parse-instruction-or-statement
           (extract-instructions-with-statements input))))
