(ns advent-of-code.day4
  (:require
   [clojure.java.io :as io]
   [clojure.string :as str]
   [clojure.set :as set]))

(def input
  (slurp (io/resource "input4")))

(defn split-by-pairs
  "Split input by pairs of Elves."
  [input]
  (map #(str/split % #",")
       (str/split-lines input)))

(defn parse-sections
  "Parse sections into a set."
  [sections]
  (set
   (let [[start end] (str/split sections #"-")]
     (range (Integer. start)
            (inc (Integer. end))))))

(def pairs
  (map #(map parse-sections %)
       (split-by-pairs input)))

(defn sub-or-superset?
  "Is set1 a subset or superset of set2?"
  [set1 set2]
  (or (set/subset? set1 set2)
      (set/superset? set1 set2)))

(defn intersection?
  "Is set1 an intersection of set2?"
  [set1 set2]
  ((comp not empty?) (set/intersection set1 set2)))

(defn analyse-pairs
  "Count pairs that satisfy given predicate."
  [pred pairs]
  (->> pairs
       (map #(apply pred %))
       (filter true?)
       (count)))

(def part-1
  (analyse-pairs sub-or-superset? pairs))

(def part-2
  (analyse-pairs intersection? pairs))
