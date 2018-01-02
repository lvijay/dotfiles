;; September 2nd 2009

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(eclim-eclipse-dirs (quote ("~/Applications/eclipse_luna")))
 '(eclim-executable "~/Applications/eclipse_luna/eclim")
 '(eclimd-default-workspace "~/eclipse/workspace/")
 '(erc-away-nickname "lvijay")
 '(erc-modules
   (quote
    (autojoin button completion fill irccontrols list match menu move-to-prompt netsplit networks noncommands readonly ring smiley stamp track)))
 '(erc-nick "vlakshminarayanan")
 '(erc-prompt-for-password nil)
 '(erc-user-full-name "Vijay Lakshminarayanan")
 '(javascript-indent-level 2)
 '(js-indent-level 2)
 '(nxml-child-indent 4)
 '(nxml-outline-child-indent 4)
 '(package-selected-packages
   (quote
    (ox-gfm markdown-mode graphviz-dot-mode company-emacs-eclim exec-path-from-shell ecb-snapshot auto-complete eclim yaml-mode slime-scratch slime-repl php-mode paredit markdown-toc markdown-preview-mode malabar-mode magit less keywiz json-mode js2-mode javascript jabber htmlize edbi diff-git cygwin-mount csv-mode css-mode browse-kill-ring boxquote auctex)))
 '(rectangle-preview nil)
 '(safe-local-variable-values
   (quote
    ((encoding . utf-8)
     (sh-indent-comment . t)
     (paredit-mode . t)
     (major-mode . emacs-lisp)
     (variable . linum)
     (linum . t)
     (major-mode . org))))
 '(tramp-use-ssh-controlmaster-options nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;;; disable security vulnerability
;;; see https://lists.gnu.org/archive/html/emacs-devel/2017-09/msg00211.html
(eval-after-load "enriched"
  '(defun enriched-decode-display-prop (start end &optional param)
     (list start end)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; set $PATH env correctly ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'exec-path "/usr/local/bin")

(setenv "PATH" "/usr/local/bin:$PATH" t)

(exec-path-from-shell-initialize)


;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; package installers ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;
;; This was installed by package-install.el.
;; This provides support for the package system and
;; interfacing with ELPA, the package archive.
;; Move this code earlier if you want to reference
;; packages in your .emacs.

;; Add the user-contributed repositories
(require 'package)
(add-to-list 'package-archives
             '("telpa" . "http://tromey.com/elpa/"))
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "http://melpa-stable.milkbox.net/packages/") t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; emacs basic preferences ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq-default indent-tabs-mode nil      ; never use tabs
              tab-width 4               ; indent tabs with 4 spaces
              enable-recursive-minibuffers t ; use minibuffer when
                                             ; using minibuffer
              query-replace-lazy-highlight t ; highlight all matches
              )

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

;; iswitchb has been obsoleted; use ido
(ido-mode 'buffers)

;; When switching to a nonexistent buffer, just switch
(setq-default iswitchb-prompt-newbuffer nil)

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
(setq confirm-kill-emacs (lambda (x)    ; handle the annoying Command-Q
                           (string-equal "quit"
                                         (read-string
                                          "To quit emacs, type \"quit\" "))))

;; Don't close the buffer with one key on a Mac
(global-unset-key (kbd "s-k"))
(global-unset-key (kbd "s-p"))          ; disable ns-print-buffer

;; Indent line by default
(funcall (lambda ()
           (global-set-key (kbd "C-m") 'newline-and-indent)
           (global-set-key (kbd "C-j") 'newline)))

;; quiet!
(setq ring-bell-function 'ignore)       ; no beep
(setq visible-bell nil)

;; show buffers with the same name uniquely
(require 'uniquify)
(setq-default uniquify-buffer-name-style 'post-forward)

;; The latest paredit has swapped ) and M-).  Restore them.
(when nil
  (define-key paredit-mode-map (kbd ")") 'paredit-close-parenthesis-and-newline)
  (define-key paredit-mode-map (kbd "M-)") 'paredit-close-parenthesis))

;; I want ellipses
(global-set-key (kbd "C-x 8 :") (lambda (n) (interactive "p") (insert-char 8230 n t)))


;;;;;;;;;;;;;
;;; Popup ;;;
;;;;;;;;;;;;;
(add-to-list 'load-path (expand-file-name "~/.emacs.d/popup-el"))
(require 'popup)


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

  (cond ((eq major-mode 'python-mode)
         (local-set-key ")" 'python-nav-up-list)
         (local-set-key "]" 'python-nav-backward-up-list)
         (local-set-key "}" 'python-nav-up-list))
        ((member major-mode '(javascript-mode js-mode))
         (local-set-key ")" 'up-list)
         (local-set-key "]" 'up-list)
         (local-set-key "}" 'up-list))
        ((member major-mode '(java-mode c-mode))
         (local-set-key ")" 'up-list)
         (local-set-key "]" 'up-list)
         (local-set-key "}" 'up-list)))
  (local-set-key "(" (lambda (n) (interactive "P") (insert-pair n 40 41)))

  (local-set-key "[" (lambda (n) (interactive "P") (insert-pair n 91 93)))
  (local-set-key "{" (lambda (n) (interactive "P") (insert-pair n 123 125)))
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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Other programming preferences ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun lisp-preferences ()
  (paredit-mode +1)
  (linum-mode +1))

(add-hook 'lisp-interaction-mode-hook
          (lambda ()
            (lisp-preferences)
            (setq next-line-add-newlines t)))

(add-hook 'org-mode-hook (lambda () (org-mode-preferences)))
(add-hook 'text-mode-hook (lambda () (linum-mode +1)))
(add-hook 'find-file-hook (lambda () (linum-mode +1)))
(add-hook 'java-mode-hook #'c-like-prog-mode-prefs)
(add-hook 'java-mode-hook (lambda ()
                            (c-set-offset 'statement-cont '++)
                            (c-set-offset 'arglist-intro '++)))
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

(add-to-list 'auto-mode-alist '("\\.xml\\'" . sgml-mode))


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


;;;;;;;;;;;;;;;;;;
;; eclim stuff ;;;
;;;;;;;;;;;;;;;;;;
(require 'eclim)
(setq eclim-auto-save t)

;;; Set the font of all frames
(setq-default after-make-frame-functions
              (append
               after-make-frame-functions
               (list (lambda (frame)
                       (set-frame-font "-*-Menlo-normal-normal-normal-*-13-*-*-*-m-0-iso10646-1")))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Unicode abbreviations ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;(define-abbrev-table 'text-mode-abbrev-table '(
;    ("..." "…")
;    ("rarr" "→")
;    ))

;;; eof
