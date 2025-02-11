(asdf:defsystem #:aoc-2016
  :serial t
  :description "Advent of Code solutions"
  :author "Tomasz Hołubowicz <mail@alternateved.com"
  :license "MIT"
  :depends-on (#:cl-ppcre #:alexandria)
  :components
  ((:file "package")
   (:module "src"
    :serial t
    :components ((:file "day01")))))
