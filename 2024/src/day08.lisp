(defpackage :aoc-2024-08
  (:use :cl))

(in-package :aoc-2024-08)

(defvar *input* (uiop:read-file-lines "../resources/input08"))

(defun add-pairs (&rest pairs)
  (apply #'mapcar #'+ pairs))

(defun subtract-pairs (&rest pairs)
  (apply #'mapcar #'- pairs))

(defun hash-table-values (ht)
  (loop for value being the hash-value of ht
        collect value))

(defun valid-position-p (pos width height)
  (and (< -1 (first pos) width)
       (< -1 (second pos) height)))

(defun find-antennas (input)
  (let ((locations (make-hash-table))
        (width (length (first input)))
        (height (length input)))
    (dotimes (y height)
      (dotimes (x width)
        (let ((c (char (nth y input) x)))
          (unless (char= c '#\.)
            (push (list x y) (gethash (char (nth y input) x) locations '()))))))
    (hash-table-values locations)))

(defun find-antinodes (antennas width height)
  (let ((pairs))
    (dolist (ls antennas)
      (loop for ((x1 y1) . rem) on ls do
        (loop for (x2 y2) in rem
              for dx = (- x1 x2)
              for dy = (- y1 y2)
              for l1 = (list (+ x1 dx) (+ y1 dy))
              for l2 = (list (- x2 dx) (- y2 dy))
              when (valid-position-p l1 width height)
                do (push l1 pairs)
              when (valid-position-p l2 width height)
                do (push l2 pairs))))
    pairs))

(defun find-all-antinodes (antennas width height)
  (let ((pairs))
    (dolist (ls antennas)
      (loop for ((x1 y1) . rem) on ls do
        (loop for (x2 y2) in rem
              for dx = (- x1 x2)
              for dy = (- y1 y2) do
                (loop for n from 1
                      for l1 = (list x1 y1)
                        then (add-pairs l1 (list dx dy))
                      for l2 = (list x2 y2)
                        then (subtract-pairs l2 (list dx dy))
                      when (valid-position-p l1 width height)
                        do (push l1 pairs)
                      when (valid-position-p l2 width height)
                        do (push l2 pairs)
                      while (or (valid-position-p l1 width height)
                                (valid-position-p l2 width height))))))
    pairs))

(defun calculate-antinodes (input fun)
  (let ((antennas (find-antennas input))
        (width (length (first input)))
        (height (length input)))
    (length (remove-duplicates
             (funcall fun antennas width height)
             :test 'equal))))

(defun part-1 (input)
  (calculate-antinodes input #'find-antinodes))

(defun part-2 (input)
  (calculate-antinodes input #'find-all-antinodes))
