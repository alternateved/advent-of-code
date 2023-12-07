(define-module (day3))

(use-modules (srfi srfi-1)
             (ice-9 regex)
             (utility))

(define (parse-game-record record alst)
  (let ((matches (string-match "Game ([0-9]+): (.+$)" record)))
    (if matches
        (let* ((game-id (string->number (substring record (match:start matches 1) (match:end matches 1))))
               (sets (string-split (substring record (match:start matches 2) (match:end matches 2)) #\;))
               (cubes (parse-sets sets)))
          (acons game-id cubes alst)))))

(define (compare-cubes key cubes match str)
  (let ((value (last (assq key cubes))))
    (list key (if match
                  (let ((new-value (string->number (substring str (match:start match 1) (match:end match 1)))))
                    (if (> new-value value) new-value value))
                  value))))

(define (parse-sets sets)
  (let loop ((cubes (list (list 'red 0) (list 'green 0) (list 'blue 0))) (sets sets))
    (if (null? sets)
        cubes
        (let* ((red-match (string-match "([0-9]+) red" (car sets)))
               (green-match (string-match "([0-9]+) green" (car sets)))
               (blue-match (string-match "([0-9]+) blue" (car sets)))
               (red-cubes (compare-cubes 'red cubes red-match (car sets)))
               (green-cubes (compare-cubes 'green cubes green-match (car sets)))
               (blue-cubes (compare-cubes 'blue cubes blue-match (car sets))))
          (loop (list red-cubes blue-cubes green-cubes) (cdr sets))))))

(define (filter-cubes game red green blue)
  (and (>= red (last (assq 'red (cdr game))))
       (>= green (last (assq 'green (cdr game))))
       (>= blue (last (assq 'blue (cdr game))))))

(define (calculate-cubes-power game)
  (* (last (assq 'red (cdr game)))
     (last (assq 'green (cdr game)))
     (last (assq 'blue (cdr game)))))

(define lines (file->lines "2023/resources/input2"))

(define part-1
  (fold + 0 (map car (filter
                      (lambda (game)
                        (filter-cubes game 12 13 14))
                      (fold parse-game-record '() lines)))))

(define part-2
  (fold + 0 (map calculate-cubes-power (fold parse-game-record '() lines))))
