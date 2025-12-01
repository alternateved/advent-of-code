package day01

import (
	"testing"

	"github.com/alternateved/advent-of-code/2025/util"
)

func TestPart1(t *testing.T) {
	result := Part1(util.ReadInput(1, true))
	expected := 3

	if result != 3 {
		t.Errorf("Result was incorrect, got: %d, want: %d.", result, expected)
	}
}
