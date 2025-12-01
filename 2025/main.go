package main

import (
	"fmt"
	"time"

	"github.com/alternateved/advent-of-code/2025/day01"
	"github.com/alternateved/advent-of-code/2025/util"
)

func main() {
	start := time.Now()
	input := util.ReadInput(1, false)
	result := day01.Part1(input)
	fmt.Printf("Day %d Part %d: %v (%v)\n", 1, 1, result, time.Since(start))
}
