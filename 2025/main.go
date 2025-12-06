package main

import (
	"fmt"
	"time"

	"github.com/alternateved/advent-of-code/2025/day01"
	"github.com/alternateved/advent-of-code/2025/day02"
	"github.com/alternateved/advent-of-code/2025/day03"
	"github.com/alternateved/advent-of-code/2025/day04"
	"github.com/alternateved/advent-of-code/2025/day05"
	"github.com/alternateved/advent-of-code/2025/day06"
	"github.com/alternateved/advent-of-code/2025/util"
)

func main() {
	for i := 1; i <= 6; i++ {
		util.FetchInput(i)
	}

	var start time.Time
	var input string
	var day, result int

	day = 1
	start = time.Now()
	input = util.ReadInput(day, "", "")
	result = day01.Part1(input)
	fmt.Printf("Day %d Part %d: %v (%v)\n", day, 1, result, time.Since(start))

	start = time.Now()
	input = util.ReadInput(day, "", "")
	result = day01.Part2(input)
	fmt.Printf("Day %d Part %d: %v (%v)\n", day, 2, result, time.Since(start))

	day = 2
	start = time.Now()
	input = util.ReadInput(day, "", "")
	result = day02.Part1(input)
	fmt.Printf("Day %d Part %d: %v (%v)\n", day, 1, result, time.Since(start))

	start = time.Now()
	input = util.ReadInput(day, "", "")
	result = day02.Part2(input)
	fmt.Printf("Day %d Part %d: %v (%v)\n", day, 2, result, time.Since(start))

	day = 3
	start = time.Now()
	input = util.ReadInput(day, "", "")
	result = day03.Part1(input)
	fmt.Printf("Day %d Part %d: %v (%v)\n", day, 1, result, time.Since(start))

	start = time.Now()
	input = util.ReadInput(day, "", "")
	result = day03.Part2(input)
	fmt.Printf("Day %d Part %d: %v (%v)\n", day, 2, result, time.Since(start))

	day = 4
	start = time.Now()
	input = util.ReadInput(day, "", "")
	result = day04.Part1(input)
	fmt.Printf("Day %d Part %d: %v (%v)\n", day, 1, result, time.Since(start))

	start = time.Now()
	input = util.ReadInput(day, "", "")
	result = day04.Part2(input)
	fmt.Printf("Day %d Part %d: %v (%v)\n", day, 2, result, time.Since(start))

	day = 5
	start = time.Now()
	input = util.ReadInput(day, "", "")
	result = day05.Part1(input)
	fmt.Printf("Day %d Part %d: %v (%v)\n", day, 1, result, time.Since(start))

	start = time.Now()
	input = util.ReadInput(day, "", "")
	result = day05.Part2(input)
	fmt.Printf("Day %d Part %d: %v (%v)\n", day, 2, result, time.Since(start))

	day = 6
	start = time.Now()
	input = util.ReadInput(day, "", "")
	result = day06.Part1(input)
	fmt.Printf("Day %d Part %d: %v (%v)\n", day, 1, result, time.Since(start))
}
