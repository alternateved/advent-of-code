(defpackage :aoc-2016-05
  (:use :cl :alexandria))

(in-package :aoc-2016-05)

(defvar *input* (uiop:read-file-string "../resources/input05"))

(defun bytes-to-hex-string (bytes)
  (with-output-to-string (s)
    (loop for byte across bytes do
      (format s "~2,'0X" byte))))

(defun calculate-hash (s n)
  (bytes-to-hex-string
   (md5:md5sum-string
    (concatenate 'string s (write-to-string n)))))

(defun find-ordered-password (input)
  (loop for n from 0
        for hash = (calculate-hash input n)
        when (string= "00000" (subseq hash 0 5))
          collect (char hash 5) into password
        when (= 8 (length password))
          do (return (format nil "~{~a~}" password))))

(defun find-unordered-password (input)
  (loop with password = (make-array 8 :initial-element nil)
        for n from 0
        for hash = (calculate-hash input n)
        for pos = (digit-char-p (char hash 5))
        when (string= "00000" (subseq hash 0 5))
          do (when-let ((pos (digit-char-p (char hash 5))))
               (when (and (> 8 pos) (not (aref password pos)))
                 (setf (aref password pos) (char hash 6))))
        when (every #'identity password)
          do (return (coerce password 'string))))

(defun part-1 (input)
  (find-ordered-password input))

(defun part-2 (input)
  (find-unordered-password input))
