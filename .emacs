(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(safe-local-variable-values
   '((paredit-mode . t) (variable . linum) (linum . t) (major-mode . org))))

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )


;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; package installers ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; auto-install setup
(require 'auto-install)
(setq auto-install-directory (expand-file-name "~/.emacs.d/auto-install/"))

;;; package -- package installer
;(add-to-list 'load-path "c:/emacs-23.1/lisp/package")
;(load "package")
;(package-initialize)

;;; marmalade -- package archive for emacs lisp
;; fully compatible with package.el and ELPA
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))


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
(toggle-uniquify-buffer-names)

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
(progn (server-force-delete) (sleep-for 1) (server-start 1) (message "Restarted server"))

;; Don't quit emacs
(global-unset-key (kbd "C-x C-c"))

;; Indent line by default
(funcall (lambda ()
           (global-set-key (kbd "C-m") 'newline-and-indent)
           (global-set-key (kbd "C-j") 'newline)))


;;;;;;;;;;;;;;;;;;;;;;;;
;;; save all history ;;;
;;;;;;;;;;;;;;;;;;;;;;;;
(require 'savehist)
(savehist-mode 1)
(setq history-length 5000)


;;;;;;;;;;;;;;;;;
;;; ChangeLog ;;;
;;;;;;;;;;;;;;;;;
(setq add-log-full-name "Vijay Lakshminarayanan"
      add-log-mailing-address "laksvij@gmail.com"
      add-log-always-start-new-record t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; programming configurations ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun swap-cm-cj ()
  (local-set-key (kbd "C-m") 'newline-and-indent)
  (local-set-key (kbd "C-j") 'newline))

(defun vl-insert-pair (open close)
  (insert open)
  (save-excursion
    (insert close)))

(defun vl-close-parens ()
  (interactive)
  (backward-up-list)
  (forward-sexp))

(defmacro vl-create-insertion-close-pair (open close)
  `(lambda ()
     (interactive)
     (vl-insert-pair ,open ,close)))

(defun c-like-prog-mode-prefs ()
  (linum-mode +1)
  (swap-cm-cj)
  (setq parens-require-spaces nil)
  (local-set-key (kbd "(") #'insert-parentheses)
  (local-set-key (kbd ")") #'vl-close-parens)

  (local-set-key (kbd "[") (vl-create-insertion-close-pair "[" "]"))
  (local-set-key (kbd "]") #'vl-close-parens)

  (local-set-key (kbd "{") (vl-create-insertion-close-pair "{" "}"))
  (local-set-key (kbd "}") #'vl-close-parens)

  (local-set-key (kbd "'") (vl-create-insertion-close-pair "'" "'"))
  (local-set-key (kbd "\"") (vl-create-insertion-close-pair "\"" "\""))

  (subword-mode))

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
(add-hook 'python-mode-hook #'c-like-prog-mode-prefs)
(add-hook 'emacs-lisp-mode-hook (lambda () (linum-mode +1) (paredit-mode +1)))
(add-hook 'js2-mode-hook #'c-like-prog-mode-prefs)
(add-hook 'js2-mode-hook (lambda ()
                           (setq forward-sexp-function nil)
                           (local-set-key (kbd "C-M-f") 'forward-sexp)))
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
      (acons "COMMIT_EDITMSG" 'git-commit-file-mode auto-mode-alist))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Other emacs customizations ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "C:/code/git/twitching")
(require 'twitching)
(load (expand-file-name "~/.emacs.d/twitching/config.el.gpg") t nil)

;;; eof
