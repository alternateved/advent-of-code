package day05

import (
	"log"
	"strconv"
	"strings"
)

func parseRanges(raw []string) [][2]int {
	ranges := make([][2]int, 0, len(raw))
	for _, r := range raw {
		ids := strings.Split(r, "-")

		start, err := strconv.Atoi(ids[0])
		if err != nil {
			log.Fatal(err)
		}

		end, err := strconv.Atoi(ids[1])
		if err != nil {
			log.Fatal(err)
		}

		ranges = append(ranges, [2]int{start, end})
	}

	return ranges
}

func Part1(input string) int {
	data := strings.Split(input, "\n\n")
	ingredients := strings.Split(data[1], "\n")
	ranges := parseRanges(strings.Split(data[0], "\n"))
	fresh := map[int]struct{}{}

	for _, ingredient := range ingredients {
		in, err := strconv.Atoi(ingredient)
		if err != nil {
			log.Fatal(err)
		}

		for _, r := range ranges {
			if in >= r[0] && in <= r[1] {
				fresh[in] = struct{}{}
			}
		}
	}

	return len(fresh)
}

func Part2(input string) int {
	data := strings.Split(input, "\n\n")
	ranges := parseRanges(strings.Split(data[0], "\n"))

	for {
		merged := false

		for a := range ranges {
			startA := ranges[a][0]
			endA := ranges[a][1]

			for b := range ranges {
				if a == b {
					continue
				}
				startB := ranges[b][0]
				endB := ranges[b][1]

				if startB <= endA+1 && endB >= startA-1 {
					newStart := min(startA, startB)
					newEnd := max(endA, endB)
					ranges[a] = [2]int{newStart, newEnd}
					ranges = append(ranges[:b], ranges[b+1:]...)
					merged = true
					break
				}
			}
			if merged {
				break
			}
		}

		if !merged {
			break
		}
	}

	var sum int
	for _, r := range ranges {
		sum += r[1] - r[0] + 1
	}

	return sum
}
