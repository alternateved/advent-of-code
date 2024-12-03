(asdf:defsystem #:advent-of-code
  :serial t
  :description "Advent of Code solutions"
  :author "Tomasz Hołubowicz <mail@alternateved.com"
  :license "MIT"
  :depends-on (#:cl-ppcre)
  :components
  ((:file "package")
   (:module "src"
    :serial t
    :components ((:file "day1")
                 (:file "day2")
                 (:file "day3")))))
