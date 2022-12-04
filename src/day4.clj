(ns day4
  (:require [clojure.java.io :as io]
            [clojure.string :as str]            
            [clojure.set :as set]))

(def input (slurp (io/resource "input4")))

(defn split-by-pairs
  "Split input by pairs of Elves."
  [input]
  (map #(str/split % #",")
       (str/split-lines input)))

(defn parse-section
  "Parse section into a set."
  [section]
  (into #{}
        (let [[start end] (str/split section #"-")]
          (range (Integer. start)
                 (+ (Integer. end) 1)))))

(def pairs
  (map #(map parse-section %)
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

(def part-1
  (get (frequencies
        (map #(apply sub-or-superset? %) pairs))
       true))

(def part-2
  (get (frequencies
        (map #(apply intersection? %) pairs))
       true))
