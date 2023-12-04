(define-module (day1))

(use-modules (srfi srfi-1)
             (ice-9 match)
             (ice-9 regex)
             (utility))

(define (flatten lst)
  (cond
   ((null? lst) '())
   ((pair? (car lst))
    (append (flatten (car lst))
            (flatten (cdr lst))))
   (else (cons (car lst) (flatten (cdr lst))))))

(define (word->digit word)
  (match word
    ("zero" '("0"))
    ("one" '("1"))
    ("two" '("2"))
    ("three" '("3"))
    ("four" '("4"))
    ("five" '("5"))
    ("six" '("6"))
    ("seven" '("7"))
    ("eight" '("8"))
    ("nine" '("9"))
    ("oneight" '("1" "8"))
    ("threeight" '("3" "8"))
    ("fiveight" '("5" "8"))
    ("nineight" '("9" "8"))
    ("twone" '("2" "1"))
    ("eightwo" '("8" "2"))
    (else (list word))))

(define regex-1
  (make-regexp "[0-9]"))

(define regex-2
  (make-regexp "[0-9]|zero|one|two|three|four|five|six|seven|eight|nine|oneight|twone|eightwo|threeight|fiveight|nineight"))

(define (get-digits rx string)
  (flatten
   (map word->digit
        (map match:substring
             (list-matches rx string)))))

(define (get-digits-1 string)
  (get-digits regex-1 string))

(define (get-digits-2 string)
  (get-digits regex-2 string))

(define (digits->number lst)
  (string->number (string-append (first lst) (last lst))))

(define lines (file->lines "2023/resources/input1"))
(define part-1 (fold + 0 (map digits->number (map get-digits-1 lines))))
(define part-2 (fold + 0 (map digits->number (map get-digits-2 lines))))


