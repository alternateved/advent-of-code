(ns advent-of-code.day3
  (:require
   [clojure.java.io :as io]
   [clojure.string :as str]
   [clojure.set :as set]))

(def input
  (str/split-lines (slurp (io/resource "input3"))))

(defn split-in-half
  "Split collection in half."
  [coll]
  (split-at (/ (count coll) 2) coll))

(defn setify
  "Transform compartments into sets of characters."
  [compartments]
  (map #(set (char-array %)) compartments))

(defn find-intersections
  "Find all intersections in setified compartments."
  [input]
  (concat (map #(apply set/intersection %) input)))

(defn upper?
  "Check if character is upper-case."
  [c]
  (= (str c) (str/upper-case c)))

(defn prioritize
  "Convert item to priority."
  [c]
  (if (upper? c)
    ;; Upper-case characters starts at 65
    (- (int c) 38)
    ;; Lower-case characters starts at 97
    (- (int c) 96)))

(def common-item-types
  (->> input
       (map split-in-half)
       (map setify)
       (find-intersections)
       (into [] cat)))

(def part-1
  (transduce (map prioritize) + common-item-types))

(def all-badges
  (->> input
       (partition 3)
       (map setify)
       (find-intersections)
       (into [] cat)))

(def part-2
  (transduce (map prioritize) + all-badges))
