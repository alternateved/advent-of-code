package day03

import (
	"log"
	"strconv"
	"strings"

	"github.com/alternateved/advent-of-code/2025/util"
)

func findLargestJoltage(bank string, n int) string {
	bankLen := len(bank)
	batteries := make([]byte, 0, bankLen)
	i := 0

	for len(batteries) < n {
		toSkip := (bankLen - i) - (n - len(batteries))
		maxJolt := bank[i]
		maxPos := i

		for j := i; j <= i+toSkip && j < bankLen; j++ {
			if bank[j] > maxJolt {
				maxJolt = bank[j]
				maxPos = j
			}
		}

		batteries = append(batteries, maxJolt)
		i = maxPos + 1
	}

	return string(batteries)
}

func calculateTotalJoltage(input string, n int) int {
	banks := strings.Split(input, "\n")
	batteries := make([]int, 0, len(banks))

	for _, bank := range banks {
		jolt := findLargestJoltage(bank, n)
		pair, err := strconv.Atoi(string(jolt))
		if err != nil {
			log.Fatal(err)
		}

		batteries = append(batteries, pair)
	}

	return util.Sum(batteries)
}

func Part1(input string) int {
	return calculateTotalJoltage(input, 2)
}

func Part2(input string) int {
	return calculateTotalJoltage(input, 12)
}
