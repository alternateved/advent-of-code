package day04

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
			input: util.ReadInput(4, "../", "_example"),
			want:  13,
		},
		{
			name:  "Actual input",
			input: util.ReadInput(4, "../", ""),
			want:  1516,
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
