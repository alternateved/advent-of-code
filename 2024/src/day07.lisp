(defpackage :aoc/2024/07
  (:use :cl))

(in-package :aoc/2024/07)

(defvar *input* (uiop:read-file-lines "../resources/input07"))

(defun parse-line (line)
  (destructuring-bind (test-value numbers) (cl-ppcre:split ":" line)
    (list (parse-integer test-value)
          (mapcar #'parse-integer (cl-ppcre:all-matches-as-strings "\\d+" numbers)))))

(defun concat (a b)
  (parse-integer
   (concatenate 'string
                (write-to-string a)
                (write-to-string b))))

(defun generate-operations (ops &optional concatp)
  (if (null (rest ops))
      '(())
      (let ((rem (generate-operations (rest ops) concatp)))
        (append
         (mapcar (lambda (r) (cons '+ r)) rem)
         (mapcar (lambda (r) (cons '* r)) rem)
         (when concatp (mapcar (lambda (r) (cons 'concat r)) rem))))))

(defun build-expression (numbers ops)
  (if (null ops)
      (first numbers)
      (let ((expr (list (first ops) (first numbers) (second numbers))))
        (loop for op in (rest ops)
              for num in (rest (rest numbers))
              do (setf expr (list op expr num)))
        expr)))

(defun evaluate-operations (test-value numbers &optional concatp)
  (let ((operations (generate-operations numbers concatp)))
    (loop for op in operations
          for result = (eval (build-expression numbers op))
          thereis (= result test-value))))

(defun gather-results (equations &optional concatp)
  (loop for (test-value numbers) in equations
        when (evaluate-operations test-value numbers concatp)
          sum test-value))

(defun part-1 (input)
  (let ((equations (mapcar #'parse-line input)))
    (gather-results equations)))

(defun part-2 (input)
  (let ((equations (mapcar #'parse-line input)))
    (gather-results equations t)))
