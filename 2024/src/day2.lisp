(in-package :advent-of-code)

(defun separate-reports (lines)
  (loop for line in lines
        collect (mapcar #'parse-integer
                        (uiop:split-string line))))

(defun check-report (report &optional dampenerp)
  (loop with rising
        with falling
        with difference
        for (a b) on report
        while b
        for distance = (abs (- a b))
        do (when (< a b) (setf rising t))
           (when (> a b) (setf falling t))
           (when (or (< distance 1) (> distance 3)) (setf difference t))
           (when (and dampenerp (or (and rising falling) difference))
             (return-from check-report (check-report (remove a report :count 1))))
        never (or (and rising falling) difference)))

(defvar input (read-lines-from-file "../resources/input2"))

(defun part-1 (input)
  (count t (mapcar #'check-report
                   (separate-reports input))))

;; FIXME
(defun part-2 (input)
  (count t (mapcar (lambda (r) (check-report r t))
                   (separate-reports input))))

