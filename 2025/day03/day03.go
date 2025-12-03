package day03

import (
	"log"
	"strconv"
	"strings"
)

func Part1(input string) int {
	banks := strings.Split(input, "\n")
	batteries := make([]int, 0, len(banks))

	for _, bank := range banks {
		var firstIndex int
		var firstBattery int
		for i := range len(bank) - 1 {
			battery, err := strconv.Atoi(string(bank[i]))
			if err != nil {
				log.Fatal(err)
			}

			if battery > firstBattery {
				firstIndex = i
				firstBattery = battery
			}
		}

		var secondIndex int
		var secondBattery int
		for i := firstIndex + 1; i < len(bank); i++ {
			battery, err := strconv.Atoi(string(bank[i]))
			if err != nil {
				log.Fatal(err)
			}

			if battery > secondBattery && i != firstIndex {
				secondIndex = i
				secondBattery = battery
			}
		}

		pair, err := strconv.Atoi(string([]byte{bank[firstIndex], bank[secondIndex]}))
		if err != nil {
			log.Fatal(err)
		}
		batteries = append(batteries, pair)
	}

	var sum int
	for _, bat := range batteries {
		sum += bat
	}

	return sum
}
