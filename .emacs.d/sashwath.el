
(defun sashwath-say-number ()
  (interactive)
  (let ((number (thing-at-point 'word)))
    (when number
      (let* ((echo (format "echo %S" number))
             (say "say -v Samantha")
             (replace-o-with-0 "gsub(/O/, \"0\", $0)")
             (replace-leading-zeros "gsub(/^0+/, \"\", $0)")
             (is-number-p "$0 ~ /^[0-9]+$/")
             (awk (format "awk '{ %s; %s; if (%s) system(\"%s \" $0) }'"
                          replace-o-with-0 replace-leading-zeros
                          is-number-p say))
             (command (format "%s | %s" echo awk)))
        (shell-command command)
        (message "")))))                ; suppress shell message

(defvar sashwath-mode-map
  (let ((keymap (make-sparse-keymap))
        (nodigits t))
    ;(suppress-keymap keymap nodigits)
    (define-key keymap (kbd "a") (lambda () (interactive) (insert "A")))
    (define-key keymap (kbd "b") (lambda () (interactive) (insert "B")))
    (define-key keymap (kbd "c") (lambda () (interactive) (insert "C")))
    (define-key keymap (kbd "d") (lambda () (interactive) (insert "D")))
    (define-key keymap (kbd "e") (lambda () (interactive) (insert "E")))
    (define-key keymap (kbd "f") (lambda () (interactive) (insert "F")))
    (define-key keymap (kbd "g") (lambda () (interactive) (insert "G")))
    (define-key keymap (kbd "h") (lambda () (interactive) (insert "H")))
    (define-key keymap (kbd "i") (lambda () (interactive) (insert "I")))
    (define-key keymap (kbd "j") (lambda () (interactive) (insert "J")))
    (define-key keymap (kbd "k") (lambda () (interactive) (insert "K")))
    (define-key keymap (kbd "l") (lambda () (interactive) (insert "L")))
    (define-key keymap (kbd "m") (lambda () (interactive) (insert "M")))
    (define-key keymap (kbd "n") (lambda () (interactive) (insert "N")))
    (define-key keymap (kbd "o") (lambda () (interactive) (insert "O")))
    (define-key keymap (kbd "p") (lambda () (interactive) (insert "P")))
    (define-key keymap (kbd "q") (lambda () (interactive) (insert "Q")))
    (define-key keymap (kbd "r") (lambda () (interactive) (insert "R")))
    (define-key keymap (kbd "s") (lambda () (interactive) (insert "S")))
    (define-key keymap (kbd "t") (lambda () (interactive) (insert "T")))
    (define-key keymap (kbd "u") (lambda () (interactive) (insert "U")))
    (define-key keymap (kbd "v") (lambda () (interactive) (insert "V")))
    (define-key keymap (kbd "w") (lambda () (interactive) (insert "W")))
    (define-key keymap (kbd "x") (lambda () (interactive) (insert "X")))
    (define-key keymap (kbd "y") (lambda () (interactive) (insert "Y")))
    (define-key keymap (kbd "z") (lambda () (interactive) (insert "Z")))
    (define-key keymap (kbd "0") (lambda () (interactive) (insert "O")))
    (define-key keymap (kbd "<f8>") 'sashwath-say-number)
    keymap))

(define-derived-mode sashwath-mode nil "Sashwath"
  "Major mode for viewing tweets.
\\{sashwath-mode-map}")

(add-hook 'sashwath-mode-hook (lambda ()
                                (show-paren-mode -1)
                                (text-scale-set 1)))

;;; sashwath.el ends here
