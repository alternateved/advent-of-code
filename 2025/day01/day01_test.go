package day01

import (
	"testing"

	"github.com/alternateved/advent-of-code/2025/util"
)

func TestPart1(t *testing.T) {
	result := Part1(util.ReadInput(1, true))
	expected := 3

	if result != expected {
		t.Errorf("Result was incorrect, got: %d, want: %d.", result, expected)
	}
}

func TestPart2(t *testing.T) {
	result := Part2(util.ReadInput(1, true))
	expected := 6

	if result != expected {
		t.Errorf("Result was incorrect, got: %d, want: %d.", result, expected)
	}
}
