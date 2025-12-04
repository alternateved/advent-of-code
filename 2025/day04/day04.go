package day04

import (
	"strings"
)

func isValid(x, y, width, height int) bool {
	validX := x > -1 && x < width
	validY := y > -1 && y < height
	return validX && validY
}

func Part1(input string) int {
	lines := strings.Split(input, "\n")
	dir := [8][2]int{{-1, -1}, {-1, 0}, {-1, 1}, {0, -1}, {0, 1}, {1, -1}, {1, 0}, {1, 1}}
	height := len(lines)
	width := len(lines[0])
	sum := 0

	for y, line := range lines {

	walking:
		for x, c := range line {
			if c == '@' {
				p := 0

				for _, d := range dir {
					dx := x + d[0]
					dy := y + d[1]

					if isValid(dx, dy, width, height) {
						if lines[dy][dx] == '@' {
							p++
						}

						if p > 3 {
							continue walking
						}
					}
				}
				sum++
			}
		}
	}

	return sum
}
