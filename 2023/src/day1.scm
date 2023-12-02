(define-module (day1))

(use-modules (utility))
(use-modules (ice-9 regex))

(define (first lst)
  (car lst))

(define (last lst)
  (car (last-pair lst)))

(define (fold f b l)
  (cond
   ((null? l) b)
   (else (f (car l) (fold f b (cdr l))))))

(define (flatten lst)
  (cond
   ((null? lst) '())
   ((pair? (car lst))
    (append (flatten (car lst))
            (flatten (cdr lst))))
   (else (cons (car lst) (flatten (cdr lst))))))

(define (word->digit word)
  (cond 
   ((string= word "zero") '("0"))
   ((string= word "one") '("1"))
   ((string= word "two") '("2"))
   ((string= word "three") '("3"))
   ((string= word "four") '("4"))
   ((string= word "five") '("5"))
   ((string= word "six") '("6"))
   ((string= word "seven") '("7"))
   ((string= word "eight") '("8"))
   ((string= word "nine") '("9"))
   ((string= word "oneight") '("1" "8"))
   ((string= word "threeight") '("3" "8"))
   ((string= word "fiveight") '("5" "8"))
   ((string= word "nineight") '("9" "8"))
   ((string= word "twone") '("2" "1"))
   ((string= word "eightwo") '("8" "2"))
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


