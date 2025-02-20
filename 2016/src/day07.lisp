(defpackage :aoc-2016-07
  (:use :cl))

(in-package :aoc-2016-07)

(defvar *input* (uiop:read-file-lines "../resources/input07"))

(defun sanitize-results (r)
  (mapcar (lambda (s) (cl-ppcre:regex-replace-all "\\[|\\]" s "")) r))

(defun extract-outside-brackets (input)
  (sanitize-results
   (cl-ppcre:all-matches-as-strings
    "([a-z]+)\\[\|\\]([a-z]+)" input)))

(defun extract-within-brackets (input)
  (sanitize-results
   (cl-ppcre:all-matches-as-strings
    "\\[([a-z]+)\\]" input)))

(defun check-tls (part)
  (loop with l = (length part)
        for i from 0 below l
        while (<= (+ i 4) l)
        for c1 = (char part i)
        for c2 = (char part (+ i 1))
        for c3 = (char part (+ i 2))
        for c4 = (char part (+ i 3))
        thereis (and (char= c1 c4)
                     (char= c2 c3)
                     (not (char= c1 c2)))))

(defun find-possible-bab (part)
  (loop with l = (length part)
        for i from 0 below l
        while (<= (+ i 3) l)
        for c1 = (char part i)
        for c2 = (char part (+ i 1))
        for c3 = (char part (+ i 2))
        when (and (char= c1 c3) (not (char= c1 c2)))
          collect (format nil "~{~a~}" (list c2 c1 c2))))

(defun check-bab (part babs)
  (loop with l = (length part)
        for i from 0 below l
        while (<= (+ i 3) l)
        for c1 = (char part i)
        for c2 = (char part (+ i 1))
        for c3 = (char part (+ i 2))
        for mbab = (format nil "~{~a~}" (list c1 c2 c3))
        thereis (member mbab babs :test #'string=)))

(defun part-1 (input)
  (loop for ip in input
        for ob = (mapcar #'check-tls (extract-outside-brackets ip))
        for wb = (mapcar #'check-tls (extract-within-brackets ip))
        when (and (some #'identity ob) (notany #'identity wb))
          count it))

(defun part-2 (input)
  (loop for ip in input
        for ob = (extract-outside-brackets ip)
        for wb = (extract-within-brackets ip)
        for babs = (remove-duplicates (mapcan #'find-possible-bab ob) :test #'string=)
        when (some (lambda (part) (check-bab part babs)) wb)
          count it))
