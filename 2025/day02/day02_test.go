package day02

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
			input: util.ReadInput(2, "../", "_example"),
			want:  1227775554,
		},
		{
			name:  "Actual input",
			input: util.ReadInput(2, "../", ""),
			want:  13919717792,
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
			input: util.ReadInput(2, "../", "_example"),
			want:  4174379265,
		},
		{
			name:  "Actual input",
			input: util.ReadInput(2, "../", ""),
			want:  14582313461,
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
