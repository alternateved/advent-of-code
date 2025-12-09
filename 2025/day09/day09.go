package day09

import (
	"log"
	"strconv"
	"strings"
)

type point struct {
	x int
	y int
}

func parsePoints(input string) []point {
	lines := strings.Split(input, "\n")
	points := make([]point, len(lines))

	for i, line := range lines {
		before, after, _ := strings.Cut(line, ",")

		x, err := strconv.Atoi(before)
		if err != nil {
			log.Fatal(err)
		}

		y, err := strconv.Atoi(after)
		if err != nil {
			log.Fatal(err)
		}

		points[i] = point{x, y}
	}

	return points
}

func abs(n int) int {
	if n < 0 {
		return -n
	}
	return n
}

func Part1(input string) int {
	points := parsePoints(input)

	var maxArea int
	for i := range points {
		for j := i + 1; j < len(points); j++ {
			p1 := points[i]
			p2 := points[j]

			a := abs(p2.x-p1.x) + 1
			b := abs(p2.y-p1.y) + 1
			area := a * b

			if area > maxArea {
				maxArea = area
			}
		}
	}

	return maxArea
}
