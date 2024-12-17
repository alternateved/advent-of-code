(defpackage :aoc-2024-09
  (:use :cl))

(in-package :aoc-2024-09)

(defvar *input* (uiop:read-file-string "../resources/input09"))

(defun parse-disk-map (input)
  (loop with l = (length input)
        for x from 0 below l by 2
        for i from 0
        for f = (digit-char-p (char input x))
        for s = (if (< (1+ x) l) (digit-char-p (char input (1+ x))) 0)
        when f
          collect (list i f) into files
        when (and s (> s 0))
          collect (list nil s) into files
        finally (return files)))

(defun represent-blocks (disk-map)
  (loop for (index size) in disk-map
        nconc (make-list size :initial-element index)))

(defun compact-files (blocks)
  (let ((result (copy-list blocks)))
    (loop for e in (reverse blocks)
          for pos = (position nil result)
          while pos
          unless (eql nil e)
            do (setf (nth pos result) e)
          do (setf result (butlast result)))
    result))

(defun compact-whole-files (disk-map)
  (let ((result (copy-list disk-map)))
    (loop for (index size) in (reverse disk-map)
          for pos = (position-if (lambda (e) (and (not (first e)) (>= (second e) size))) result)
          when pos do
            (let ((rem (- (second (nth pos result)) size)))
              (setf (nth pos result) (list index size))
              (setf result (nsubstitute (list nil size) (list index size) result :from-end t :test #'equal :count 1))
              (when (plusp rem)
                (push (list nil rem) (cdr (nthcdr pos result))))))
    result))

(defun calculate-checksum (files)
  (loop for i from 0 below (length files)
        for e = (nth i files)
        when e sum (* i e)))

(defun part-1 (input)
  (calculate-checksum
   (compact-files
    (represent-blocks
     (parse-disk-map input)))))

(defun part-2 (input)
  (calculate-checksum
   (represent-blocks
    (compact-whole-files
     (parse-disk-map input)))))
