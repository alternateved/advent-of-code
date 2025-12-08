package day08

import (
	"log"
	"math"
	"strconv"
	"strings"
)

type point struct {
	x int
	y int
	z int
}

func parsePoints(input string) []point {
	points := make([]point, 0, 1000)

	for line := range strings.SplitSeq(input, "\n") {
		raw := strings.Split(line, ",")

		x, err := strconv.Atoi(raw[0])
		if err != nil {
			log.Fatal(err)
		}

		y, err := strconv.Atoi(raw[1])
		if err != nil {
			log.Fatal(err)
		}

		z, err := strconv.Atoi(raw[2])
		if err != nil {
			log.Fatal(err)
		}

		points = append(points, point{x, y, z})

	}

	return points
}

func distance(p1, p2 point) float64 {
	dx := p1.x - p2.x
	dy := p1.y - p2.y
	dz := p1.z - p2.z
	return math.Sqrt(float64(dx*dx + dy*dy + dz*dz))
}

func Part1(input string) int {
	points := parsePoints(input)
	edges := make(map[int]int, len(points)/2)

	for i := range points {
		minDist := math.MaxFloat64
		nearest := -1

		for j := range points {
			if i == j {
				continue
			}

			if d := distance(points[i], points[j]); d < minDist {
				minDist = d
				nearest = j
			}
		}
		edges[i] = nearest
	}

	return 0
}
