(ns advent-of-code.day5
  (:require
   [clojure.java.io :as io]
   [clojure.string :as str]))

(def input (slurp (io/resource "input5")))

(defn separate-parts
  "Separates drawing from instructions."
  [position input]
  (str/split-lines
   (position (str/split input #"\n\n"))))

(defn transpose
  "Transpose matrix"
  [m]
  (apply mapv vector m))

(defn stackify
  "Assign number to a stack."
  [[s & r]]
  (hash-map (Character/digit s 10)
            (apply str r)))

(defn parse-drawing
  "Parse drawing of starting stacks of crates."
  [input]
  (->> input
       (separate-parts first)
       (reverse)
       (transpose)
       (map #(apply str %))
       (filter not-brackets?)
       (remove str/blank?)
       (map #(str/trim %))
       (map stackify)
       (apply merge)))

(defn instructify
  "Transform provided instruction into more readable map."
  [[ _ q _ s1 _ s2]]
  (hash-map :quantity (Integer. q)
            :from (Integer. s1)
            :to (Integer. s2)))

(defn parse-instructions
  "Parse... well, instructions."
  [input]
  (->> input
       (separate-parts peek)
       (map #(str/split % #" "))
       (map instructify)))

(def parsed-drawing (parse-drawing input))
(def parsed-instructions (parse-instructions input))

(defn update-drawing-CM9000
  "Update drawing crate by crate."
  [drawing from to]
  (assoc drawing
         from (apply str (drop-last (get drawing from)))
         to (str (get drawing to) (last (get drawing from)))))

(defn perform-move-CM9000
  "Execute move and decrement quantity."
  [drawing move]
  (if (= (:quantity move) 0)
    drawing
    (recur (update-drawing-CM9000 drawing (:from move) (:to move))
           (update move :quantity dec))))

(defn execute-instructions-CM9000
  "Apply all instructions to the drawing."
  [drawing [move & rest]]
  (if (nil? move)
    drawing
    (recur (perform-move-CM9000 drawing move) rest)))

(defn get-rearrangement
  "Concatenate characters that are on top of each stack."
  ([drawing]
   (get-rearrangement drawing 1 ""))
  ([drawing i result]
   (if (> i (count (keys drawing)))
     result
     (recur drawing
            (inc i)
            (str result (last (get drawing i)))))))

(def part-1
  (get-rearrangement (execute-instructions-CM9000 parsed-drawing parsed-instructions)))

(defn update-drawing-CM9001
  "Update drawing swiftly."
  [drawing from to q]
  (assoc drawing
         from (apply str (drop-last q (get drawing from)))
         to (apply str (get drawing to) (take-last q (get drawing from)))))

(defn perform-move-CM9001
  "Execute move and update drawing."
  [drawing move]
  (update-drawing-CM9001 drawing (:from move) (:to move) (:quantity move)))

(defn execute-instructions-CM9001
  "Apply all instructions to the drawing."
  [drawing [move & rest]]
  (if (nil? move)
    drawing
    (recur (perform-move-CM9001 drawing move) rest)))

(def part-2
  (get-rearrangement (execute-instructions-CM9001 parsed-drawing parsed-instructions)))
