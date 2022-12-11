(ns advent-of-code.day8
  (:require
   [clojure.java.io :as io]
   [clojure.string :as str]))

(def input (slurp (io/resource "input8")))

(defn parse-grid
  "Parse input into 2-dimensional vector."
  [input]
  (into [] (comp
            (map #(str/split % #""))
            (map (fn [coll] (mapv #(Integer. %) coll))))
        (str/split-lines input)))

(defn transpose
  "Transpose matrix"
  [m]
  (apply mapv vector m))

(defn add-index-x
  [coll]
  (map #(assoc {} :t %1 :x %2)
       coll
       (range (count coll))))

(defn add-index-y
  [coll]
  (map #(merge %1 {:y %2})
       coll
       (range (count coll))))

(defn add-coordinates
  "Create a map with coordinates for each tree position."
  [coll]
  (map #(add-index-y %) (transpose (map #(add-index-x %) coll))))

(defn mark-visible-trees
  "Mark trees that are visible."
  [row coll]
  (map (fn [{:keys [t x y]}]
         (let [column (nth (transpose coll) x)
               up (subvec (nth coll y) 0 x)
               right (subvec column (inc y))
               left (subvec column 0 y)
               down (subvec (nth coll y) (inc x))]
           (if (or (some true? (map empty? (list left right up down)))
                   (every? #(> t %) left)
                   (every? #(> t %) right)
                   (every? #(> t %) up)
                   (every? #(> t %) down))
             1 0)))
       row))

(defn count-all-visible-trees-alt
  "Calculate the number of visible trees in provided collection."
  [coords coll]
  (transduce (comp
              (map #(mark-visible-trees % coll))
              (map #(reduce + %))) + 0 coords))

(def grid-of-trees (parse-grid input))
(def coordinates (add-coordinates grid-of-trees))
(def part-1 (count-all-visible-trees grid-of-trees))

(defn calculate-viewing-distance
  "Calculate viewing distance from tree in one direction."
  [coll t]
  (let [trees-count (count (take-while #(> t %) coll))
        coll-count (count coll)]
    (cond
      (empty? coll) 0
      (= trees-count coll-count) trees-count
      :else (inc trees-count))))

(defn calculate-row-scenic-score
  "Calculate scenic score for each tree in a row."
  [row coll]
  (map (fn [{:keys [t x y]}]
         (let [column (nth (transpose coll) x)
               up (subvec (nth coll y) 0 x)
               right (subvec column (inc y))
               left (subvec column 0 y)
               down (subvec (nth coll y) (inc x))]
           (* (calculate-viewing-distance (rseq left) t)
                (calculate-viewing-distance right t)
                (calculate-viewing-distance (rseq up) t)
                (calculate-viewing-distance down t))))
       row))

(defn get-highest-scenic-score
  "Find maximum scenic score for tree in provided collection."
  [coords coll]
  (apply max (into '() (comp
                        (map #(calculate-row-scenic-score % coll))
                        (map #(apply max %))) coords)))

(def part-2 (get-highest-scenic-score coordinates (parse-grid input)))
