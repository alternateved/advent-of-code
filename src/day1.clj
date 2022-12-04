(ns day1
  (:require [clojure.java.io :as io]
            [clojure.string :as str]))

(def input (slurp (io/resource "input1")))

(defn split-by-elf
  [string]
  (map #(str/split-lines %)
       (str/split string #"\n\n")))

(defn sum-calories-by-elf
  [vectors]
  (sort >
        (map (fn [vector]
               (reduce (fn [total snack]
                         (+ total (Integer. snack)))
                       0
                       vector))
             vectors)))

(def list-of-calories
  (sum-calories-by-elf (split-by-elf input)))

(def part-1
  (first list-of-calories))

(def part-2
  (reduce + (take 3 list-of-calories)))

