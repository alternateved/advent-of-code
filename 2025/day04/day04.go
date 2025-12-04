package day04

import "strings"

var directions = [8][2]int{
	{-1, -1}, {-1, 0}, {-1, 1}, {0, -1},
	{0, 1}, {1, -1}, {1, 0}, {1, 1},
}

func isValid(x, y, width, height int) bool {
	validX := x > -1 && x < width
	validY := y > -1 && y < height
	return validX && validY
}

func removeRolls(input string, iterative bool) int {
	lines := strings.Split(input, "\n")
	height := len(lines)
	width := len(lines[0])
	totalRemoved := 0

	removed := make([][]bool, height)
	for i := range removed {
		removed[i] = make([]bool, width)
	}

	for {
		removedThisRound := 0

		for y, line := range lines {
			for x, c := range line {
				if c == '@' && !removed[y][x] {
					neighbors := 0

					for _, dir := range directions {
						dx := x + dir[0]
						dy := y + dir[1]

						if !isValid(dx, dy, width, height) {
							continue
						}

						if removed[dy][dx] {
							continue
						}

						if lines[dy][dx] == '@' {
							neighbors++
						}
					}

					if neighbors <= 3 {
						totalRemoved++
						removedThisRound++

						if iterative {
							removed[y][x] = true
						}
					}
				}
			}
		}

		if !iterative || removedThisRound == 0 {
			break
		}
	}

	return totalRemoved
}

func Part1(input string) int {
	return removeRolls(input, false)
}

func Part2(input string) int {
	return removeRolls(input, true)
}
