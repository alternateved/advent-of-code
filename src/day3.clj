(ns day3
  (:require [clojure.java.io :as io]
            [clojure.string :as str]
            [clojure.set :as set]))

(def input (str/split-lines (slurp (io/resource "input3"))))

(defn split-in-half
  "Split collection in half."
  [coll]
  (split-at (/ (count coll) 2) coll))

(defn setify
  "Transform compartments into sets of characters."
  [compartments]
  (map #(into #{} (char-array %))
       compartments))

(defn find-intersections
  "Find all intersections in setified compartments."
  [input]
  (concat (map #(apply set/intersection %)
               input)))

(defn upper?
  "Check if character is upper-case."
  [char]
  (= (str char)
     (str/upper-case char)))

(defn prioritize
  "Convert item to priority."
  [char]
  (if (upper? char)
    ;; Upper-case characters starts at 65
    (- (int char) 38)
    ;; Lower-case characters starts at 97
    (- (int char) 96)))

(def common-item-types
  (into [] cat (find-intersections
                (map setify
                     (map split-in-half input)))))

(def part-1
  (reduce + (map prioritize common-item-types)))

(def all-badges
  (into [] cat (find-intersections
                (map setify (partition 3 input)))))

(def part-2
  (reduce + (map prioritize all-badges)))
