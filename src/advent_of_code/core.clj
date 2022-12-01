(ns advent-of-code.core
  (:require [clojure.java.io :as io]))

(def input (slurp (io/resource "input_1")))

(defn str->int
  [str]
  (Integer. str))

(defn split-by-elf
  [string]
  (map #(clojure.string/split % #"\n")
       (clojure.string/split string #"\n\n")))

(defn sum-calories-by-elf
  [vectors]
  (sort >
        (map (fn [vector]
               (reduce (fn [total snack]
                         (+ total (str->int snack)))
                       0
                       vector))
             vectors)))

(def list-of-calories
  (sum-calories-by-elf (split-by-elf input)))

(def elf-with-most-calories
  (first list-of-calories))

(def top-three-sum
  (reduce + (take 3 list-of-calories)))

