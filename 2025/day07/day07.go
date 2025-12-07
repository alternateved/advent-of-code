package day07

import (
	"slices"
	"strings"
)

func Part1(input string) int {
	lines := strings.Split(input, "\n")
	beam := make([]int, 0, len(lines[0]))

	for i, c := range lines[0] {
		if c == 'S' {
			beam = append(beam, i)
		}
	}

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
