package util

import (
	"fmt"
	"log"
	"os"
	"strings"
)

func ReadInput(day int, test bool) string {
	var path string
	if test {
		path = fmt.Sprintf("../resources/input%02d_test", day)
	} else {
		path = fmt.Sprintf("resources/input%02d", day)
	}

	data, err := os.ReadFile(path)
	if err != nil {
		log.Fatal(err)
	}

	return strings.TrimRight(string(data), "\n")
}
