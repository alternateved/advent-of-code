(defpackage :aoc-2015-04
  (:use :cl))

(in-package :aoc-2015-04)

(defvar *input* (uiop:read-file-string "../resources/input04"))

(defun bytes-to-hex-string (bytes)
  (with-output-to-string (s)
    (loop for byte across bytes do
      (format s "~2,'0X" byte))))

(defun calculate-hash (s n)
  (bytes-to-hex-string
   (md5:md5sum-string
    (concatenate 'string s (write-to-string n)))))

(defun mine-coins (input substr)
  (loop for n from 0
        for hash = (calculate-hash input n)
        when (string= substr (subseq hash 0 (length substr)))
          do (return n)))

(defun part-1 (input)
  (mine-coins input "00000"))

(defun part-2 (input)
  (mine-coins input "000000"))
