(in-package :advent-of-code)

(defun read-lines-from-file (filename)
  (with-open-file (stream filename)
    (loop for line = (read-line stream nil)
          while line
          collect line)))
