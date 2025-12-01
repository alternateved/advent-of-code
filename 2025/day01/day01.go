package day01

import (
	"log"
	"strconv"
	"strings"
)

func Part1(input string) int {
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

		position = (position + size + (dir * dist)) % size
		if position == 0 {
			result = result + 1
		}
	}

	return result
}
