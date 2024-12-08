(defpackage :aoc/2024/06
  (:use :cl))

(in-package :aoc/2024/06)

(defvar *input* (uiop:read-file-lines "../resources/input06"))

(defun add-pairs (&rest pairs)
  (apply #'mapcar #'+ pairs))

(defun hash-table-keys (ht)
  (loop for key being the hash-keys of ht collect key))

(defun valid-position-p (pos width height)
  (and (< -1 (first pos) width)
       (< -1 (second pos) height)))

(defun find-objects (input)
  (let ((guard)
        (obstacles)
        (width (length (first input)))
        (height (length input)))
    (dotimes (y height)
      (dotimes (x width)
        (let ((c (char (nth y input) x)))
          (cond
            ((char= c #\^) (setf guard (list x y)))
            ((char= c #\#) (push (list x y) obstacles))
            (t nil)))))
    (list guard obstacles)))

(defun find-all-positions (guard obstacles input)
  (let ((positions)
        (dir '(0 -1))
        (current-direction 0)
        (directions '((0 -1) (1 0) (0 1) (-1 0)))
        (width (length (first input)))
        (height (length input)))
    (loop for pos = guard then (add-pairs pos dir)
          while (valid-position-p pos width height)
          do (push pos positions)
          when (member (add-pairs dir pos) obstacles :test #'equal)
            do (setf current-direction (mod (1+ current-direction) 4)
                     dir (nth current-direction directions)))
    positions))

(defun calculate-distinct-positions (input)
  (destructuring-bind (guard obstacles) (find-objects input)
    (length (remove-duplicates (find-all-positions guard obstacles input) :test #'equal))))

(defun part-1 (input)
  (calculate-distinct-positions input))
