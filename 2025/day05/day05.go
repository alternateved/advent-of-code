package day05

import (
	"cmp"
	"log"
	"slices"
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

func mergeIntervals(intervals [][2]int) [][2]int {
	slices.SortFunc(intervals, func(a, b [2]int) int {
		return cmp.Compare(a[0], b[0])
	})

	merged := [][2]int{intervals[0]}

	for i := 1; i < len(intervals); i++ {
		current := intervals[i]
		last := &merged[len(merged)-1]

		if current[0] <= last[1]+1 {
			last[1] = max(last[1], current[1])
		} else {
			merged = append(merged, current)
		}
	}

	return merged
}

func Part1(input string) int {
	data := strings.Split(input, "\n\n")
	ingredients := strings.Split(data[1], "\n")
	ranges := parseRanges(strings.Split(data[0], "\n"))
	merged := mergeIntervals(ranges)
	count := 0

	for _, ingredient := range ingredients {
		in, err := strconv.Atoi(ingredient)
		if err != nil {
			log.Fatal(err)
		}

		for _, r := range merged {
			if in >= r[0] && in <= r[1] {
				count++
			}
		}
	}

	return count
}

func Part2(input string) int {
	data := strings.Split(input, "\n\n")
	ranges := parseRanges(strings.Split(data[0], "\n"))
	merged := mergeIntervals(ranges)

	var sum int
	for _, r := range merged {
		sum += r[1] - r[0] + 1
	}

	return sum
}
