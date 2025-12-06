package util

import (
	"fmt"
	"io"
	"log"
	"net/http"
	"os"
	"strings"

	"github.com/joho/godotenv"
)

const baseURL = "https://adventofcode.com/2025/day/%d/input"

func ReadInput(day int, prefix, suffix string) string {
	path := fmt.Sprintf("%sresources/input%02d%s", prefix, day, suffix)
	data, err := os.ReadFile(path)
	if err != nil {
		log.Fatal(err)
	}

	return strings.TrimRight(string(data), "\n")
}

func FetchInput(day int) {
	path := fmt.Sprintf("resources/input%02d", day)

	if _, err := os.Stat(path); err == nil {
		return
	}

	err := godotenv.Load()
	if err != nil {
		log.Fatal(err)
	}

	session := os.Getenv("SESSION")
	url := fmt.Sprintf(baseURL, day)

	client := &http.Client{}
	req, err := http.NewRequest("GET", url, nil)
	if err != nil {
		log.Fatalf("Error creating HTTP request: %v\n", err)
	}

	req.Header.Add("Cookie", "session="+session)

	res, err := client.Do(req)
	if err != nil {
		log.Fatalf("Error making HTTP request: %v\n", err)
	}
	defer func() { _ = res.Body.Close() }()

	if res.StatusCode != http.StatusOK {
		log.Fatalf("Unexpected HTTP status: %v\n", res.StatusCode)
	}

	body, err := io.ReadAll(res.Body)
	if err != nil {
		log.Fatalf("Error reading response body: %v\n", err)
	}

	err = os.WriteFile(path, body, 0644)
	if err != nil {
		log.Fatalf("Couldn't write file: %v\n", err)
	}
}
