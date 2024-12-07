(defpackage :aoc/2024/05
  (:use :cl))

(in-package :aoc/2024/05)

(defvar *input*
  (cl-ppcre:split "\\n\\s*\\n" (uiop:read-file-string "../resources/input05")))

(defun parse-rule (rule)
  (cl-ppcre:register-groups-bind ((#'parse-integer n m))
      ("(\\d+)\\|(\\d+)" rule)
    (list n m)))

(defun parse-update (update)
  (mapcar #'parse-integer
          (cl-ppcre:all-matches-as-strings "\\d+" update)))

(defun middle (lst)
  (nth (floor (length lst) 2) lst))

(defun create-table (rules)
  (let ((ht (make-hash-table)))
    (dolist (pair rules)
      (push (second pair) (gethash (first pair) ht '())))
    ht))

(defun compare-pages (a b rules)
  (member b (gethash a rules)))

(defun find-correct-update (update rules)
  (loop for page in update
        for pos from 0
        for rule = (gethash page rules)
        always (loop for page in rule
                     for rule-position = (position page update)
                     always (or (not rule-position)
                                (< pos rule-position)))
        finally (return update)))

(defun find-incorrect-update (update rules)
  (loop for page in update
        for pos from 0
        for rule = (gethash page rules)
        when (loop for r in rule
                   for rule-position = (position r update)
                   thereis (and rule-position (> pos rule-position)))
          return update))

(defun sort-pages (update rules)
  (sort update (lambda (a b) (compare-pages a b rules))))

(defun get-middle-page (pages rules)
  (declare (ignore rules))
  (middle pages))

(defun get-sorted-middle-page (pages rules)
  (middle (sort-pages pages rules)))

(defun calculate-result (input pred calculate)
  (let* ((rules (mapcar #'parse-rule (cl-ppcre:split "\\n" (first input))))
         (updates (mapcar #'parse-update (cl-ppcre:split "\\n" (second input))))
         (rules-table (create-table rules)))
    (loop for update in updates
          for analyzed = (funcall pred update rules-table)
          when analyzed
            sum (funcall calculate analyzed rules-table))))

(defun part-1 (input)
  (calculate-result input #'find-correct-update #'get-middle-page))

(defun part-2 (input)
  (calculate-result input #'find-incorrect-update #'get-sorted-middle-page))
