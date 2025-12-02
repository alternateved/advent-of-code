package day02

import (
	"log"
	"strconv"
	"strings"
)

func Part1(input string) int {
	var sum int

	for r := range strings.SplitSeq(input, ",") {
		ids := strings.Split(r, "-")

		firstID, err := strconv.Atoi(ids[0])
		if err != nil {
			log.Fatal(err)
		}

		lastID, err := strconv.Atoi(ids[1])
		if err != nil {
			log.Fatal(err)
		}

		for i := firstID; i <= lastID; i++ {
			s := strconv.Itoa(i)
			half := len(s) / 2

			if s[:half] == s[half:] {
				sum += i
			}
		}
	}

	return sum
}
