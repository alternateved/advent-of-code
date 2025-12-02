package day02

import (
	"log"
	"strconv"
	"strings"
)

func sumInvalidIDs(input string, predicate func(int) bool) int {
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
			if predicate(i) {
				sum += i
			}
		}
	}

	return sum
}

func hasRepeatedHalves(n int) bool {
	s := strconv.Itoa(n)
	half := len(s) / 2

	if len(s)%2 != 0 {
		return false
	}

	return s[:half] == s[half:]
}

func hasRepeatedPattern(n int) bool {
	s := strconv.Itoa(n)
	sLen := len(s)

	if sLen == 1 {
		return false
	}

	for i := 1; i <= sLen/2; i++ {
		if sLen%i != 0 {
			continue
		}

		pattern := s[0:i]
		isRepeating := true

		for j := i; j < sLen; j += i {
			if s[j:j+i] != pattern {
				isRepeating = false
				break
			}
		}

		if isRepeating {
			return true
		}
	}

	return false
}

func Part1(input string) int {
	return sumInvalidIDs(input, hasRepeatedHalves)
}

func Part2(input string) int {
	return sumInvalidIDs(input, hasRepeatedPattern)
}
