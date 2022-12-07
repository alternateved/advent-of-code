(ns advent-of-code.day6
  (:require [clojure.java.io :as io]))

(def input (slurp (io/resource "input6")))

(defn identify-start-of-packet
  "Detect start-of-packet marker in provided datastream."
  ([packet-size input]
   (identify-start-of-packet packet-size [] 0 input))
  ([packet-size packet position [head & tail]]
   (cond
     (nil? head) 0
     (> packet-size (count packet)) (recur packet-size (conj packet head) (inc position) tail)
     (and (= packet-size (count packet))
          (= packet-size (count (set packet)))) position
     :else (recur packet-size (conj (vec (rest packet)) head) (inc position) tail))))

(def part-1 (identify-start-of-packet 4 input))
(def part-2 (identify-start-of-packet 14 input))
