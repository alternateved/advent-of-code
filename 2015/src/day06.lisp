(defpackage :aoc-2015-06
  (:use :cl))

(in-package :aoc-2015-06)

(defvar *input* (uiop:read-file-lines "../resources/input06"))

(defun parse-instruction (instruction)
  (cl-ppcre:register-groups-bind (cmd (#'parse-integer x1 y1 x2 y2))
      ("(turn on|turn off|toggle) (\\d+),(\\d+) through (\\d+),(\\d+)" instruction)
    (list
     (cond ((string= "turn on" cmd) :turn-on)
           ((string= "turn off" cmd) :turn-off)
           (t :toggle))
     (list x1 y1)
     (list x2 y2))))

(defun sum-grid (grid)
  (loop for i below (array-total-size grid)
        sum (row-major-aref grid i)))

(defun modify-light (cmd val &optional controlp)
  (case cmd
    (:turn-on (if controlp (+ val 1) 1))
    (:turn-off (if controlp (max 0 (- val 1)) 0))
    (:toggle (if controlp (+ 2 val) (- 1 val)))))

(defun modify-grid (ins grid &optional controlp)
  (destructuring-bind (cmd start end) ins
    (loop for y from (second start) to (second end) do
      (loop for x from (first start) to (first end) do
        (let ((index (+ x (* y 1000))))
          (setf (aref grid index)
                (modify-light cmd (aref grid index) controlp)))))))

(defun calculate-grid (instructions grid &optional controlp)
  (sum-grid
   (loop for ins in instructions
         do (modify-grid ins grid controlp)
         finally (return grid))))

(defun part-1 (input)
  (calculate-grid (mapcar #'parse-instruction input) (make-array (* 1000 1000))))

(defun part-2 (input)
  (calculate-grid (mapcar #'parse-instruction input) (make-array (* 1000 1000)) t))
