package main

import (
	"fmt"
	"time"

	"github.com/alternateved/advent-of-code/2025/day01"
	"github.com/alternateved/advent-of-code/2025/util"
)

func main() {
	var start time.Time
	var input string
	var day, result int

	day = 1
	start = time.Now()
	input = util.ReadInput(1, "", "")
	result = day01.Part1(input)
	fmt.Printf("Day %d Part %d: %v (%v)\n", day, 1, result, time.Since(start))

	start = time.Now()
	input = util.ReadInput(1, "", "")
	result = day01.Part2(input)
	fmt.Printf("Day %d Part %d: %v (%v)\n", 1, 2, result, time.Since(start))
}
