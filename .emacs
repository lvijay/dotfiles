;; September 2nd 2009

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(erc-away-nickname "lvijay")
 '(erc-email-userid "laksvij@jeemail.com")
 '(erc-modules (quote (autojoin button completion fill irccontrols list match menu move-to-prompt netsplit networks noncommands readonly ring smiley stamp track)))
 '(erc-nick "lvijay")
 '(erc-prompt-for-password nil)
 '(erc-user-full-name "Vijay Lakshminarayanan")
 '(javascript-indent-level 2)
 '(js-indent-level 2)
 '(safe-local-variable-values
   '((paredit-mode . t) (major-mode . emacs-lisp) (variable . linum) (linum . t) (major-mode . org)))
 '(user-mail-address "laksvij@gmail.com"))

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )


;;; Add .emacs.d to the load-path by default
(add-to-list 'load-path (expand-file-name "~/.emacs.d"))


;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; package installers ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;
;; This was installed by package-install.el.
;; This provides support for the package system and
;; interfacing with ELPA, the package archive.
;; Move this code earlier if you want to reference
;; packages in your .emacs.
(if (= emacs-major-version 24)
    (load "package.el")
  (load (expand-file-name "~/.emacs.d/elpa/package.el")))

(add-to-list 'load-path (expand-file-name "~/.emacs.d/elpa"))

(when (load "package.el")
  (package-initialize)
  (add-to-list 'package-archives
               '("telpa" . "http://tromey.com/elpa/"))
  ;; Add the user-contributed repository
  (add-to-list 'package-archives
               '("marmalade" . "http://marmalade-repo.org/packages/")))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; emacs basic preferences ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq-default indent-tabs-mode nil      ; never use tabs
              tab-width 4               ; indent tabs with 4 spaces
              enable-recursive-minibuffers t) ; use minibuffer when
                                              ; using minibuffer

;; disable newbie warnings
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'set-goal-column 'disabled nil)

;; don't make me type `yes' when `y' will do.
(fset 'yes-or-no-p 'y-or-n-p)

;; make `next-line-add-newlines' buffer local
(make-variable-buffer-local 'next-line-add-newlines)

;; show matching parens
(show-paren-mode +1)

;; use iswitchb when switching buffers
(iswitchb-mode +1)

;; When switching to a nonexistent buffer, just switch
(setq-default iswitchb-prompt-newbuffer nil)

;; show unique buffer names when two buffers have the same name
;(toggle-uniquify-buffer-names)

;; disable toolbar
(tool-bar-mode -1)

;; disable scrollbar
(scroll-bar-mode -1)

;; always show column number
(column-number-mode +1)

;; don't show selected mark
(transient-mark-mode -1)

;; use shift and arrows to switch between windows
(windmove-default-keybindings)

;; start emacs server to use with emacsclient
(unwind-protect (server-force-delete)
  (progn
    (server-start)
    (message "Restarted server")))

;; Don't quit emacs
(global-unset-key (kbd "C-x C-c"))

;; Indent line by default
(funcall (lambda ()
           (global-set-key (kbd "C-m") 'newline-and-indent)
           (global-set-key (kbd "C-j") 'newline)))

;; quiet!
;(set-message-beep 'silent)

;; show buffers with the same name uniquely
(require 'uniquify)
(setq-default uniquify-buffer-name-style 'post-forward)

;; The latest paredit has swapped ) and M-).  Restore them.
(when (load-file (expand-file-name "~/.emacs.d/elpa/paredit-20/paredit.el"))
  (define-key paredit-mode-map (kbd ")") 'paredit-close-round-and-newline)
  (define-key paredit-mode-map (kbd "M-)") 'paredit-close-round))


;;;;;;;;;;;;;;;;;;;;;;;;
;;; save all history ;;;
;;;;;;;;;;;;;;;;;;;;;;;;
(require 'savehist)
(savehist-mode 1)
(setq history-length 100000)


;;;;;;;;;;;;;;;;;
;;; ChangeLog ;;;
;;;;;;;;;;;;;;;;;
(setq add-log-full-name "Vijay Lakshminarayanan"
      add-log-mailing-address "laksvij@gmail.com"
      add-log-always-start-new-record t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Whitespace mode customizations ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'whitespace)
(setq-default whitespace-style '(tabs lines-tail trailing))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; programming configurations ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; `c-subword-mode' was renamed to `subword-mode' in Emacs 24
(when (not (functionp 'subword-mode))   ; subword-mode doesn't exist
  (if (functionp 'c-subword-mode)
      ;; but c-subword-mode exists
      (defun subword-mode (&optional arg)
        (interactive "P")
        (c-subword-mode arg))
    ;; create an empty placeholder
    (defun subword-mode (&optional arg)
      (interactive "P"))))

(defun swap-cm-cj ()
  (local-set-key (kbd "C-m") 'newline-and-indent)
  (local-set-key (kbd "C-j") 'newline))

(defun c-like-prog-mode-prefs ()
  (linum-mode +1)
  (swap-cm-cj)
  (setq parens-require-spaces nil)

  (local-set-key "(" (lambda (n) (interactive "P") (insert-pair n 40 41)))
  (local-set-key ")" (lambda (n) (interactive "P") (up-list n)))
  (local-set-key "[" (lambda (n) (interactive "P") (insert-pair n 91 93)))
  (local-set-key "]" (lambda (n) (interactive "P") (up-list n)))
  (local-set-key "{" (lambda (n) (interactive "P") (insert-pair n 123 125)))
  (local-set-key "}" (lambda (n) (interactive "P") (up-list n)))

  (local-set-key "\"" (lambda (n) (interactive "P") (insert-pair n 34 34)))
  (local-set-key "'" (lambda (n) (interactive "P") (insert-pair n 39 39)))

  (subword-mode +1))


;;;;;;;;;;;;;;;;
;;; Org Mode ;;;
;;;;;;;;;;;;;;;;
(defun org-mode-preferences ()
  (setq parens-require-spaces nil)
  (subword-mode)
  (auto-fill-mode))

(setq-default sgml-basic-offset 4)

(defun lisp-preferences ()
  (paredit-mode +1)
  (linum-mode +1))

(add-hook 'org-mode-hook (lambda () (org-mode-preferences)))
(add-hook 'text-mode-hook (lambda () (linum-mode +1)))
(add-hook 'find-file-hook (lambda () (linum-mode +1)))
(add-hook 'java-mode-hook #'c-like-prog-mode-prefs)
(add-hook 'c-mode-hook #'c-like-prog-mode-prefs)
(add-hook 'python-mode-hook #'c-like-prog-mode-prefs)
(add-hook 'emacs-lisp-mode-hook (lambda () (linum-mode +1) (paredit-mode +1)))
(add-hook 'js2-mode-hook #'c-like-prog-mode-prefs)
(add-hook 'js2-mode-hook (lambda ()
                           (setq forward-sexp-function nil)
                           (local-set-key (kbd "C-M-f") 'forward-sexp)))
(add-hook 'js-mode-hook #'c-like-prog-mode-prefs)

;;; Use javascript-mode for all .js files.  Less intrusive than
;;; js2-mode
(add-hook 'javascript-mode #'c-like-prog-mode-prefs)
(setq auto-mode-alist (cons (cons "\\.js$" 'javascript-mode) auto-mode-alist))

(add-hook 'lisp-interaction-mode-hook (lambda ()
                                        (lisp-preferences)
                                        (setq next-line-add-newlines t)))


;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Git customization ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;
(define-derived-mode git-commit-file-mode text-mode "GitCommit"
  "Major mode for writing git commit files."
  (setq fill-column 60)
  (auto-fill-mode +1)
  (set (make-local-variable 'comment-start-skip) "#.*$"))

(setq auto-mode-alist
      (cons (cons "COMMIT_EDITMSG" 'git-commit-file-mode) auto-mode-alist))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Other emacs customizations ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/code/twitching")
(defun start-twitching ()
  (require 'twitching)
  (load (expand-file-name "~/.emacs.d/twitching/config.el.gpg") t nil))


;;;;;;;;;;;;;;;;;;;;;
;;; Markdown mode ;;;
;;;;;;;;;;;;;;;;;;;;;
(autoload 'markdown-mode "markdown-mode"
  "MarkDown mode, popular in GitHub"
  t)
(eval-after-load "markdown-mode"
  (add-hook 'markdown-mode-hook
            (lambda ()
              (auto-fill-mode +1)
              (local-set-key (kbd "C-M-f") 'forward-sexp)
              (local-set-key (kbd "C-M-b") 'backward-sexp)
              (local-set-key (kbd "C-M-u") 'backward-up-list)
              (local-set-key (kbd "C-M-d") 'down-list))))


;;;;;;;;;;;;;;;;;;;;
;;; POV-Ray mode ;;;
;;;;;;;;;;;;;;;;;;;;
(autoload 'pov-mode "pov-mode" "PoVray scene file mode" t)
(add-to-list 'auto-mode-alist '("\\.pov\\'" . pov-mode))
(add-to-list 'auto-mode-alist '("\\.inc\\'" . pov-mode))


;;;;;;;;;;;;;;;;;;;
;;; eclim stuff ;;;
;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path (expand-file-name "~/.emacs.d/eclim"))
(require 'eclim)

(setq eclim-auto-save t)
(global-eclim-mode)

;;; eof
