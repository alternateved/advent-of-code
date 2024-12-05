(defpackage :aoc/2024/04
  (:use :cl))

(in-package :aoc/2024/04)

(defun compare-word (word str)
  (or (string= word str)
      (string= (reverse word) str)))

(defun get-chars (x y input)
  (list (char (nth y input) x)
        (char (nth (1+ y) input) (1+ x))
        (char (nth (+ y 2) input) (+ x 2))
        (char (nth y input) (+ x 2))
        (char (nth (+ y 2) input) x)))

(defun count-words (input pred)
  (let ((height (length input))
        (width (length (first input))))
    (loop for y below height
          sum (loop for x below width
                    sum (funcall pred x y input)))))

(defun find-xmas-seq (x y input)
  (let ((directions '((0 1) (1 0) (1 1) (-1 1) (0 -1) (-1 0) (-1 -1) (1 -1)))
        (count 0))
    (dolist (dir directions count)
      (destructuring-bind (dx dy) dir
        (when (loop for c across "XMAS"
                    for (cx cy) = (list x y) then (list (+ cx dx) (+ cy dy))
                    always (and (< -1 cx (length (first input)))
                                (< -1 cy (length input))
                                (char= c (char (nth cy input) cx))))
          (incf count))))))

(defun find-x-mas-seq (x y input)
  (let ((count 0))
    (when (and (< x (- (length (first input)) 2))
               (< y (- (length input) 2)))
      (let ((chars (get-chars x y input)))
        (when (and (member (first chars) '(#\S #\M))
                   (every (lambda (word) (compare-word "MAS" (coerce word 'string)))
                          (list (subseq chars 0 3)
                                (list (fourth chars) (second chars) (fifth chars)))))
          (incf count))))
    count))

(defvar *input* (uiop:read-file-lines "../resources/input04"))

(defun part-1 (input)
  (count-words input #'find-xmas-seq))

(defun part-2 (input)
  (count-words input #'find-x-mas-seq))
