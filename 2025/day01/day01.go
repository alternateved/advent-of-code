package day01

import (
	"log"
	"math"
	"strconv"
	"strings"
)

func rotateDial(input string, countCrossing bool) int {
	result := 0
	position := 50
	size := 100

	for rotation := range strings.SplitSeq(input, "\n") {

		var dir int
		if string(rotation[0]) == "L" {
			dir = -1
		} else if string(rotation[0]) == "R" {
			dir = 1
		}

		dist, err := strconv.Atoi(rotation[1:])
		if err != nil {
			log.Fatal(err)
		}

		afterRotation := position + dir*dist
		if countCrossing {
			result += int(math.Abs(float64(afterRotation / size)))

			if position != 0 && afterRotation < 0 {
				result++
			}

			if afterRotation == 0 {
				result++
			}
		} else {
			if position == 0 {
				result++
			}
		}

		position = (afterRotation%size + size) % size
	}

	return result
}

func Part1(input string) int {
	return rotateDial(input, false)
}

func Part2(input string) int {
	return rotateDial(input, true)
}
