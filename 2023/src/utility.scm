(define-module (utility)
  #:export (read-lines file->lines))

(use-modules (ice-9 textual-ports))
(use-modules (ice-9 rdelim))

(define (read-lines port)
  (let loop ((lines '()))
    (let ((line (read-line port)))
      (if (eof-object? line)
          (reverse! lines)
          (loop (cons line lines))))))

(define (file->lines file)
  (let* ((port (open-input-file file))
         (lines (read-lines port)))
    (close-port port)
    lines))
