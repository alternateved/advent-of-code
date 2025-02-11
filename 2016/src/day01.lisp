(defpackage :aoc-2016-01
  (:use :cl))

(in-package :aoc-2016-01)

(defvar *input* (uiop:read-file-string "../resources/input01"))

(defun add-pairs (&rest pairs)
  (apply #'mapcar #'+ pairs))

(defun parse-instructions (input)
  (loop for ins in (cl-ppcre:split ", " input)
        for c = (char ins 0)
        for b = (parse-integer (subseq ins 1))
        collect (list c b)))

(defun direction (dir)
  (case dir
    (:N '(0 1))
    (:E '(1 0))
    (:S '(0 -1))
    (:W '(-1 0))))

(defun change-direction (dir turn)
  (let* ((directions '(:N :E :S :W))
         (pos (position dir directions)))
    (nth (mod (+ pos (if (char= turn #\R) 1 -1)) 4) directions)))

(defun calculate-distance (pos)
  (destructuring-bind (x y) pos
    (+ (abs x)
       (abs y))))

(defun destination (instructions &optional visitedp)
  (loop with dir = :N
        with pos = '(0 0)
        with visited = (make-hash-table :test 'equal)
        for (turn steps) in instructions
        for new-dir = (change-direction dir turn)
        for change = (direction new-dir)
        do (setf dir new-dir)
           (dotimes (i steps)
             (setf pos (add-pairs pos change))
             (when visitedp
               (if (gethash pos visited)
                   (return-from destination pos)
                   (setf (gethash pos visited) t))))
        finally (return pos)))

(defun part-1 (input)
  (calculate-distance (destination (parse-instructions input))))

(defun part-2 (input)
  (calculate-distance (destination (parse-instructions input) t)))
