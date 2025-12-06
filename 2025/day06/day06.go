package day06

import (
	"log"
	"strconv"
	"strings"

	"github.com/alternateved/advent-of-code/2025/util"
)

func transpose[T any](m [][]T) [][]T {
	rows := len(m)
	cols := len(m[0])
	result := make([][]T, cols)

	for i := range result {
		result[i] = make([]T, rows)

	}

	for i := range rows {
		for j := range cols {
			result[j][i] = m[i][j]
		}
	}

	return result
}

func foldMatrix(matrix [][]int, ops []string) int {
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
	height := len(lines)
	width := len(lines[0])
	numbers := make([][]int, height-1)
	ops := strings.Fields(lines[height-1])

	for i := 0; i < height-1; i++ {
		numbers[i] = make([]int, 0, width)
		for raw := range strings.FieldsSeq(lines[i]) {
			num, err := strconv.Atoi(raw)
			if err != nil {
				log.Fatal(err)
			}
			numbers[i] = append(numbers[i], num)
		}
	}

	total := foldMatrix(transpose(numbers), ops)
	return total
}

func Part2(input string) int {
	lines := strings.Split(input, "\n")
	height := len(lines)
	ops := strings.Fields(lines[height-1])

	grid := make([][]byte, height-1)
	for i := 0; i < height-1; i++ {
		grid[i] = []byte(lines[i])
	}

	numbers := make([][]int, len(ops))
	row := 0

	for _, line := range transpose(grid) {
		raw := strings.TrimSpace(string(line))
		if len(raw) == 0 {
			row++
		} else {
			num, err := strconv.Atoi(raw)
			if err != nil {
				log.Fatal(err)
			}
			numbers[row] = append(numbers[row], num)
		}
	}

	total := foldMatrix(numbers, ops)
	return total
}
