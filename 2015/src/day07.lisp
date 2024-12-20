(defpackage :aoc-2015-07
  (:use :cl :alexandria))

(in-package :aoc-2015-07)

(defvar *input* (uiop:read-file-lines "../resources/input07"))

(defun split-on-op (op string)
  (let ((pos (search op string)))
    (when pos
      (list (string-trim " " (subseq string 0 pos))
            (string-trim " " (subseq string (+ pos (length op))))))))

(defun find-operator (string)
  (let ((operators '("NOT" "AND" "OR" "LSHIFT" "RSHIFT")))
    (loop for op in operators
          when (search op string)
            do (return op))))

(defun get-op (op)
  (cond
    ((string= "AND" op) #'logand)
    ((string= "OR" op) #'logior)
    ((string= "LSHIFT" op) (lambda (a b) (ash a b)))
    ((string= "RSHIFT" op) (lambda (a b) (ash a (- b))))
    ((string= "NOT" op) (lambda (a) (logand (lognot a) #xFFFF)))))

(defun parse-argument (a)
  (or (parse-integer a :junk-allowed t) a))

(defun parse-cmd (cmd)
  (let ((operator (find-operator cmd)))
    (cond
      ((not operator)
       (list "ASSIGN" (parse-argument cmd)))
      ((string= "NOT" operator)
       (list operator (parse-argument (string-trim " " (subseq cmd 3)))))
      (t
       (destructuring-bind (a b) (split-on-op operator cmd)
         (list operator (parse-argument a) (parse-argument b)))))))

(defun parse-line (line)
  (destructuring-bind (cmd wire) (split-on-op "->" line)
    (destructuring-bind (op &rest args) (parse-cmd cmd)
      (list wire op args))))

(defun assign-hash (k v ht)
  (if (gethash k ht) nil (setf (gethash k ht) v)))

(defun assign-wire (wire wires args)
  (let ((arg (first args)))
    (if (numberp arg)
        (assign-hash wire arg wires)
        (when-let ((value (gethash arg wires)))
          (assign-hash wire value wires)))
    wires))

(defun connect-wire (wire wires cmd args)
  (let ((evaluated))
    (dolist (arg args)
      (if (numberp arg)
          (push arg evaluated)
          (when-let ((value (gethash arg wires)))
            (push value evaluated))))
    (when (length= args evaluated)
      (assign-hash wire (apply (get-op cmd) (nreverse evaluated)) wires)))
  wires)

(defun connect-wires (input wires)
  (loop until (loop for line in input
                    for (wire cmd args) = (parse-line line)
                    when (= (length input) (hash-table-count wires))
                      do (return t)
                    if (string= "ASSIGN" cmd)
                      do (setf wires (assign-wire wire wires args))
                    else
                      do (setf wires (connect-wire wire wires cmd args))))
  wires)

(defun part-1 (input)
  (gethash "a" (connect-wires input (make-hash-table :test #'equal))))

(defun part-2 (input)
  (let ((wire-a (gethash "a" (connect-wires input (make-hash-table :test #'equal))))
        (new-wires (make-hash-table :test #'equal)))
    (setf (gethash "b" new-wires) wire-a)
    (gethash "a" (connect-wires input new-wires))))
