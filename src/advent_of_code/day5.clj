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

(defn without-brackets?
  "Returns true if string is free of brackets."
  [s]
  (not (or (str/includes? s "[")
           (str/includes? s "]"))))

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
       (transduce (comp
                   (map #(apply str %))
                   (filter without-brackets?)
                   (remove str/blank?)
                   (map #(str/trim %))
                   (map stackify)) conj)
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
       (transduce (comp (map #(str/split % #" "))
                        (map instructify)) conj)))

(def parsed-drawing (parse-drawing input))
(def parsed-instructions (parse-instructions input))

(defn update-drawing
  "Update drawing, obviously,"
  [drawing from to quantity]
  (assoc drawing
         from (apply str (drop-last quantity (get drawing from)))
         to (apply str (get drawing to) (take-last quantity (get drawing from)))))

(defn perform-move-CM9000
  "Execute move and decrement quantity."
  [drawing move]
  (if (= (:quantity move) 0)
    drawing
    (recur (update-drawing drawing (:from move) (:to move) 1)
           (update move :quantity dec))))

(defn perform-move-CM9001
  "Execute move and update drawing."
  [drawing move]
  (update-drawing drawing (:from move) (:to move) (:quantity move)))

(defn execute-instructions
  "Apply all instructions to the drawing."
  [model drawing [move & rest]]
  (if (nil? move)
    drawing
    (case model
      "CM9000" (recur model (perform-move-CM9000 drawing move) rest)
      "CM9001" (recur model (perform-move-CM9001 drawing move) rest))))

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
  (get-rearrangement (execute-instructions "CM9000" parsed-drawing parsed-instructions)))

(def part-2
  (get-rearrangement (execute-instructions "CM9001" parsed-drawing parsed-instructions)))
