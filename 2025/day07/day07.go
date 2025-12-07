package day07

import (
	"slices"
	"strings"
)

func markStart(line string) int {
	var start int
	for i, c := range line {
		if c == 'S' {
			start = i
		}
	}
	return start
}

func Part1(input string) int {
	lines := strings.Split(input, "\n")

	beam := make([]int, 0, len(lines[0]))
	beam = append(beam, markStart(lines[0]))

	var total int
	for _, line := range lines {
		curr := make([]int, 0, len(beam))
		for _, b := range beam {
			if line[b] == '^' {
				curr = append(curr, b-1, b+1)
				total++
			} else {
				curr = append(curr, b)
			}
		}
		beam = slices.Compact(curr)
	}

	return total
}

func Part2(input string) int {
	lines := strings.Split(input, "\n")
	start := markStart(lines[0])
	counts := make(map[[2]int]int)
	return countPaths(start, 0, lines, counts)
}

func countPaths(x, y int, lines []string, counts map[[2]int]int) int {
	if y >= len(lines) {
		return 1
	}

	key := [2]int{x, y}
	if v, ok := counts[key]; ok {
		return v
	}

	var count int
	if lines[y][x] == '^' {
		count += countPaths(x-1, y+1, lines, counts)
		count += countPaths(x+1, y+1, lines, counts)
	} else {
		count = countPaths(x, y+1, lines, counts)
	}

	counts[key] = count
	return count
}
