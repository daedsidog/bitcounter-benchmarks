(import (chezscheme))

(define (read-byte)
  (let ((char (get-char (current-input-port))))
    (if (eof-object? char)
        char
        (char->integer char))))

(define (main)
  (let loop ((longest-bits 0)
             (current-bits 0))
    (let ((char (read-byte)))
      (if (eof-object? char)
          (begin
            (when (> current-bits longest-bits)
              (set! longest-bits current-bits))
            (display longest-bits)
            (newline))
          (letrec ((bit-process 
                     (lambda (i)
                       (when (>= i 0)
                         (if (= 0 (bitwise-and (bitwise-arithmetic-shift char (- i))
                                               #x1))
                             (begin
                               (when (> current-bits longest-bits)
                                 (set! longest-bits current-bits))
                               (set! current-bits 0))
                             (set! current-bits (+ current-bits 1)))
                         (bit-process (- i 1))))))
            (bit-process 7)
            (loop longest-bits current-bits))))))

(main)
