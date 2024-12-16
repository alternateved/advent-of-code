(asdf:defsystem #:aoc-2015
  :serial t
  :description "Advent of Code solutions"
  :author "Tomasz Hołubowicz <mail@alternateved.com"
  :license "MIT"
  :depends-on (#:cl-ppcre :md5)
  :components
  ((:file "package")
   (:module "src"
    :serial t
    :components ((:file "day01")
                 (:file "day02")
                 (:file "day03")
                 (:file "day04")
                 (:file "day05")
                 (:file "day06")))))
