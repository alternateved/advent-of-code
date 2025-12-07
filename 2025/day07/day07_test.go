package day07

import (
	"testing"

	"github.com/alternateved/advent-of-code/2025/util"
)

func TestPart1(t *testing.T) {
	tests := []struct {
		name  string
		input string
		want  int
	}{
		{
			name:  "Example input",
			input: util.ReadInput(7, "../", "_example"),
			want:  21,
		},
		{
			name:  "Actual input",
			input: util.ReadInput(7, "../", ""),
			want:  1672,
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			if got := Part1(tt.input); got != tt.want {
				t.Errorf("Result was incorrect, got: %d, want: %d.", got, tt.want)
			}
		})
	}
}

func TestPart2(t *testing.T) {
	tests := []struct {
		name  string
		input string
		want  int
	}{
		{
			name:  "Example input",
			input: util.ReadInput(7, "../", "_example"),
			want:  40,
		},
		{
			name:  "Actual input",
			input: util.ReadInput(7, "../", ""),
			want:  231229866702355,
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			if got := Part2(tt.input); got != tt.want {
				t.Errorf("Result was incorrect, got: %d, want: %d.", got, tt.want)
			}
		})
	}
}
