package day06

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
			input: util.ReadInput(6, "../", "_example"),
			want:  4277556,
		},
		{
			name:  "Actual input",
			input: util.ReadInput(6, "../", ""),
			want:  3968933219902,
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
