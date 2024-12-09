(defpackage :aoc/2024/06
  (:use :cl))

(in-package :aoc/2024/06)

(defvar *input* (uiop:read-file-lines "../resources/input06"))

(defparameter *directions* #((0 -1) (1 0) (0 1) (-1 0)))

(defun add-pairs (&rest pairs)
  (apply #'mapcar #'+ pairs))

(defun hash-table-keys (ht)
  (loop for key being the hash-keys of ht collect key))

(defun list-to-hash-table (elements)
  (let ((hash (make-hash-table :test #'equal)))
    (dolist (ob elements hash)
      (setf (gethash ob hash) t))))

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
        (width (length (first input)))
        (height (length input))
        (obstacle-hash (list-to-hash-table obstacles)))
    (loop for pos = guard then (add-pairs pos dir)
          while (valid-position-p pos width height)
          do (push pos positions)
          when (gethash (add-pairs dir pos) obstacle-hash)
            do (setf current-direction (mod (1+ current-direction) 4)
                     dir (aref *directions* current-direction)))
    (remove-duplicates positions :test #'equal)))

(defun calculate-distinct-positions (input)
  (destructuring-bind (guard obstacles) (find-objects input)
    (length (find-all-positions guard obstacles input))))

(defun part-1 (input)
  (calculate-distinct-positions input))

(defun run-test (guard obstacles input)
  (let ((positions (make-hash-table :test #'equal))
        (dir '(0 -1))
        (current-direction 0)
        (width (length (first input)))
        (height (length input))
        (obstacle-hash (list-to-hash-table obstacles)))
    (loop for pos = guard then (add-pairs pos dir)
          while (valid-position-p pos width height)
          if (member dir (gethash pos positions) :test #'equal)
            do (return t)
          else do (push dir (gethash pos positions '()))
          when (gethash (add-pairs dir pos) obstacle-hash)
            do (setf current-direction (mod (1+ current-direction) 4)
                     dir (aref *directions* current-direction)))))

;; FIXME: this returns wrong results (1920, should be 1909)
(defun part-2 (input)
  (destructuring-bind (guard obstacles) (find-objects input)
    (let ((new-obstacles (remove guard (find-all-positions guard obstacles input) :test #'equal)))
      (length (loop for ob in new-obstacles
                    when (run-test guard (cons ob obstacles) input)
                      collect it)))))
