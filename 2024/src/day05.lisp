(defpackage :aoc/2024/05
  (:use :cl))

(in-package :aoc/2024/05)

(defvar *input*
  (cl-ppcre:split "\\n\\s*\\n" (uiop:read-file-string "../resources/input05")))

(defvar *example-input*
  '("47|53
97|13
97|61
97|47
75|29
61|13
75|53
29|13
97|29
53|29
61|53
97|53
61|29
47|13
75|47
97|75
47|61
75|61
47|29
75|13
53|13"
    "75,47,61,53,29
97,61,53,29,13
75,29,13
75,97,47,61,53
61,13,29
97,13,75,29,47"))

(defun parse-rule (rule)
  (cl-ppcre:register-groups-bind ((#'parse-integer n m))
      ("(\\d+)\\|(\\d+)" rule)
    (list n m)))

(defun parse-update (update)
  (mapcar #'parse-integer
          (cl-ppcre:all-matches-as-strings "\\d+" update)))

(defun hash-rules (rule table)
  (setf (gethash (first rule) table) (second rule)))

(defun middle (lst)
  (nth (floor (length lst) 2) lst))

(defun check-rules (pos rule update)
  (loop for page in rule
        for rule-position = (position page update)
        always (or (not rule-position)
                   (< pos rule-position))))

(defun analyze-update (update rules)
  (loop for page in update
        for pos from 0
        for rule = (gethash page rules)
        always (check-rules pos rule update)
        finally (return update)))

(defun create-table (rules)
  (let ((ht (make-hash-table)))
    (dolist (pair rules)
      (push (second pair) (gethash (first pair) ht '())))
    ht))

(defun part-1 (input)
  (let* ((rules (mapcar #'parse-rule (cl-ppcre:split "\\n" (first input))))
         (updates (mapcar #'parse-update (cl-ppcre:split "\\n" (second input))))
         (rules-table (create-table rules)))
    (loop for update in updates
          for analyzed = (analyze-update update rules-table)
          when analyzed
            sum (middle analyzed))))

;; NOTE: maybe try using sort for the second part?
