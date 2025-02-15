(defpackage :aoc-2016-04
  (:use :cl))

(in-package :aoc-2016-04)

(defvar *input* (uiop:read-file-lines "../resources/input04"))

(defvar *example*
  '("aaaaa-bbb-z-y-x-123[abxyz]"
    "a-b-c-d-e-f-g-h-987[abcde]"
    "not-a-real-room-404[oarel]"
    "totally-real-room-200[decoy]"))

(defun parse-room (room)
  (cl-ppcre:register-groups-bind (n (#'parse-integer i) c)
      ("^([a-z-]+)-(\\d+)\\[([a-z]+)\\]$" room)
    (list n i c)))

(defun frequencies (name)
  (let ((freq (make-hash-table)))
    (loop for c across (sort (cl-ppcre:regex-replace-all "-" name "") #'char<)
          do (incf (gethash c freq 0)))
    (sort (loop for c being the hash-keys of freq
                  using (hash-value count)
                collect (cons c count))
          #'> :key #'cdr)))

(defun calculate-checksum (alist)
  (subseq (format nil "~{~A~}" (loop for (c . n) in alist collect c)) 0 5))

(defun shift-char (c id)
  (if (char= #\- c)
      #\Space
      (code-char (+ (mod (+ (- (char-code c) 97) id) 26) 97))))

(defun decrypt-name (name id)
  (format nil "~{~A~}" (loop for c across name collect (shift-char c id))))

(defun part-1 (input)
  (loop for room in input
        for (n i c) = (parse-room room)
        for cc = (calculate-checksum (frequencies n))
        when (string= c cc)
          sum i))

(defun part-2 (input)
  (loop for room in input
        for (n i c) = (parse-room room)
        for dn = (decrypt-name n i)
        when (string= dn "northpole object storage")
          return i))
