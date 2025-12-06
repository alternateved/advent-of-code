package util

func Sum(nums []int) int {
	var sum int
	for _, n := range nums {
		sum += n
	}
	return sum
}

func Product(nums []int) int {
	product := 1
	for _, n := range nums {
		product *= n
	}
	return product
}
