package util

import (
	"fmt"
	"log"
	"os"
	"strings"
)

func ReadInput(day int) string {
	data, err := os.ReadFile(fmt.Sprintf("resources/input%02d", day))
	if err != nil {
		log.Fatal(err)
	}

	return strings.TrimRight(string(data), "\n")
}
