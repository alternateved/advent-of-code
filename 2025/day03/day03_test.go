package day03

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
			input: util.ReadInput(3, "../", "_example"),
			want:  357,
		},
		{
			name:  "Actual input",
			input: util.ReadInput(3, "../", ""),
			want:  17278,
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
