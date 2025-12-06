package day06

import (
	"log"
	"strconv"
	"strings"
)

func sum(nums []int) int {
	var sum int
	for _, n := range nums {
		sum += n
	}
	return sum
}

func product(nums []int) int {
	product := 1
	for _, n := range nums {
		product *= n
	}
	return product
}

func transpose(m [][]int) [][]int {
	rows := len(m)
	cols := len(m[0])
	result := make([][]int, cols)
	for i := range result {
		result[i] = make([]int, rows)

	}

	for i := range rows {
		for j := range cols {
			result[j][i] = m[i][j]
		}
	}
	return result
}

func Part1(input string) int {
	lines := strings.Split(input, "\n")
	numLen := len(lines[0])
	numbers := make([][]int, len(lines)-1)
	ops := strings.Fields(lines[len(lines)-1])

	for i := 0; i < len(lines)-1; i++ {
		numbers[i] = make([]int, 0, numLen)
		for raw := range strings.FieldsSeq(lines[i]) {
			num, err := strconv.Atoi(raw)
			if err != nil {
				log.Fatal(err)
			}
			numbers[i] = append(numbers[i], num)
		}
	}

	var total int
	for i, col := range transpose(numbers) {
		if ops[i] == "*" {
			total += product(col)
		} else {
			total += sum(col)
		}
	}

	return total
}
