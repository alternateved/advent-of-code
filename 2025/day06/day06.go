package day06

import (
	"log"
	"strconv"
	"strings"

	"github.com/alternateved/advent-of-code/2025/util"
)

func transpose[T any](m [][]T) [][]T {
	if len(m) == 0 || len(m[0]) == 0 {
		return [][]T{}
	}

	rows, cols := len(m), len(m[0])
	result := make([][]T, cols)

	for i := range cols {
		result[i] = make([]T, rows)
		for j := range rows {
			result[i][j] = m[j][i]
		}
	}

	return result
}

func foldMatrixWith(matrix [][]int, ops []string) int {
	var total int
	for i, col := range matrix {
		if ops[i] == "*" {
			total += util.Product(col)
		} else {
			total += util.Sum(col)
		}
	}
	return total
}

func Part1(input string) int {
	lines := strings.Split(input, "\n")
	ops := strings.Fields(lines[len(lines)-1])

	numbers := make([][]int, len(lines)-1)
	for i := range numbers {
		numbers[i] = make([]int, 0, len(lines[0]))
		for raw := range strings.FieldsSeq(lines[i]) {
			num, err := strconv.Atoi(raw)
			if err != nil {
				log.Fatal(err)
			}
			numbers[i] = append(numbers[i], num)
		}
	}

	return foldMatrixWith(transpose(numbers), ops)
}

func Part2(input string) int {
	lines := strings.Split(input, "\n")
	ops := strings.Fields(lines[len(lines)-1])

	grid := make([][]byte, len(lines)-1)
	for i := range grid {
		grid[i] = []byte(lines[i])
	}

	numbers := make([][]int, len(ops))
	row := 0

	for _, line := range transpose(grid) {
		raw := strings.TrimSpace(string(line))
		if raw == "" {
			row++
		} else {
			num, err := strconv.Atoi(raw)
			if err != nil {
				log.Fatal(err)
			}
			numbers[row] = append(numbers[row], num)
		}
	}

	return foldMatrixWith(numbers, ops)
}
