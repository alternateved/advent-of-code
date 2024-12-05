(asdf:defsystem #:aoc
  :serial t
  :description "Advent of Code solutions"
  :author "Tomasz Hołubowicz <mail@alternateved.com"
  :license "MIT"
  :depends-on (#:cl-ppcre)
  :components
  ((:file "package")
   (:module "src"
    :serial t
    :components ((:file "day01")
                 (:file "day02")
                 (:file "day03")
                 (:file "day04")
                 (:file "day05")))))
