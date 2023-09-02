(ns advent-of-code.day1
  (:require
   [clojure.java.io :as io]
   [clojure.string :as str]))

(def input
  (slurp (io/resource "input1")))

(defn split-by-elf
  "Split initial input by Elf."
  [s]
  (map #(str/split-lines %)
       (str/split s #"\n\n")))

(defn sum-calories
  "Sum calories carried by one Elf."
  [calories]
  (transduce (map #(Integer. %)) + calories))

(defn calculate-all-calories
  "Create a sorted list of sums of calories carried by each Elf."
  [input]
  (sort > (map sum-calories input)))

(def list-of-calories
  (calculate-all-calories (split-by-elf input)))

(def part-1
  (first list-of-calories))

(def part-2
  (transduce (take 3) + list-of-calories))
