(defpackage :aoc/2024/04
  (:use :cl))

(in-package :aoc/2024/04)

(defvar *input* (uiop:read-file-lines "../resources/input04"))

(defun count-words (word input)
  (let ((height (length input))
        (width (length (first input)))
        (directions '((0 1) (1 0) (1 1) (-1 1) (0 -1) (-1 0) (-1 -1) (1 -1)))
        (count 0))
    (dotimes (y height)
      (dotimes (x width)
        (dolist (dir directions)
          (when (check-direction x y dir word input)
            (incf count)))))
    count))

(defun check-direction (x y dir word input)
  (destructuring-bind (dx dy) dir
    (loop for char across word
          for (cx cy) = (list x y) then (list (+ cx dx) (+ cy dy))
          always (and (< -1 cx (length (first input)))
                      (< -1 cy (length input))
                      (char= char (aref (nth cy input) cx))))))

(defun part-1 (input)
  (count-words "XMAS" input))
