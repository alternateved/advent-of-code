package util

import (
	"fmt"
	"log"
	"os"
	"strings"
)

func ReadInput(day int, prefix, suffix string) string {
	path := fmt.Sprintf("%sresources/input%02d%s", prefix, day, suffix)
	data, err := os.ReadFile(path)
	if err != nil {
		log.Fatal(err)
	}

	return strings.TrimRight(string(data), "\n")
}
