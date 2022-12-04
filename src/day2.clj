(ns day2
  (:require [clojure.java.io :as io]
            [clojure.string :as str]))

(def input (str/split-lines (slurp (io/resource "input2"))))

(def occurences
  (frequencies input))

(def mappings {"A X" (+ 1 3)
               "A Y" (+ 2 6)
               "A Z" 3
               "B X" 1
               "B Y" (+ 2 3)
               "B Z" (+ 3 6)
               "C X" (+ 1 6)
               "C Y" 2
               "C Z" (+ 3 3)})

(defn calculate
  [key value]
  (* value (get mappings key)))

(defn calculate-total
  [occur]
  (reduce + (map (fn [[k v]]
                   (calculate k v))
                 occur)))

(def part-1 (calculate-total occurences))

(def outcomes {"X" 0
               "Y" 3
               "Z" 6})

(def shapes {"A" 1
             "B" 2
             "C" 3})

(defn win-against
  [move]
  (case move
    "A" "B"
    "B" "C"
    "C" "A"))

(defn lose-against
  [move]
  (case move
    "A" "C"
    "B" "A"
    "C" "B"))

(defn apply-strategy
  [move outcome]
  (case outcome
    "X" (lose-against move)
    "Y" (identity move)
    "Z" (win-against move)))

(defn play-round
  [round]
  (let [[move outcome] (str/split round #" ")]
    (+ (get outcomes outcome) (get shapes (apply-strategy move outcome)))))

(defn calculate-total-again
  [occur]
  (reduce + (map (fn [[k v]]
                   (* v (play-round k)))
                 occur)))

(def part-2 (calculate-total-again occurences))
