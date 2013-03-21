;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; General Settings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(server-start) ; daemonize emacs
(setq inhibit-splash-screen t
      inhibit-startup-echo-area-message t
      initial-scratch-message nil
      visible-bell t
      column-number-mode t
      confirm-nonexistent-file-or-buffer nil
      subword-mode 1
      next-line-add-newlines t
      font-lock-maximum-decoration t)
(menu-bar-mode 0) ; disable the menu bar
(show-paren-mode 1) ; highligh matching parentheses
;; font lock
(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)

;; ido
(ido-mode 1)
(setq ido-enable-flex-matching t
      ido-show-dot-for-dired t)
(ido-everywhere t)
(add-hook 'dired-mode-hook
	  '(lambda () (setq ido-enable-replace-completing-read nil))) ; disable ido for dired

; clean emacs backup files
(setq backup-by-copying t
      backup-directory-alist '(("." . "~/.emacs.backups"))
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

; set PATH correctly
(setenv "PATH"
	(shell-command-to-string "source $HOME/.bashrc && printf $PATH"))

(let ((default-directory "~/.emacs.d/"))
  (normal-top-level-add-to-load-path '("."))
  (normal-top-level-add-subdirs-to-load-path))

(setq require-final-newline t)
(setq next-line-add-newlines nil)

(setq linum-format "%d ") ; left-align the line numbers and add whitespace padding in linum-mode

(add-hook 'before-save-hook 'delete-trailing-whitespace) ; remove all trailing whitespace
					                 ; upon saving a buffer

(setq flyspell-issue-welcome-flag nil) ; flyspell

; abbrev mode
;; (setq-default abbrev-mode t)
;; (setq abbrev-file-name "~/.emacs.d/abbrev_definitions")
;; (if (file-exists-p abbrev-file-name)
;;     (quietly-read-abbrev-file))

(setq dabbrev-case-fold-search t) ; make the completition case insensitive

(setq vc-follow-symlinks t) ; follow symlinks to VC files

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Keybindings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(global-set-key (kbd "RET")
		'reindent-then-newline-and-indent)
(global-set-key (kbd "C-x C-b") 'buffer-menu) ; rebind buffer menu


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Modes
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Some utility macros for handling older versions of emacs and/or
;; dealing with new emacs installs, where the packages might not
;; be installed yet.
;; These were taken from:
;; http://emacs-fu.blogspot.jp/2008/12/using-packages-functions-only-if-they.html
(defmacro require-maybe (feature &optional file)
  "*Try to require FEATURE, but don't signal an error if `require' fails."
  `(require ,feature ,file 'noerror))

(defmacro when-available (func foo)
  "*Do something if FUNCTION is available."
  `(when (fboundp ,func) ,foo))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Language Agnostic

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ELPA
(when (require-maybe 'package)
  (add-to-list 'package-archives
	       '("marmalade" . "http://marmalade-repo.org/packages/"))
  (add-to-list 'package-archives
	       '("melpa" . "http://melpa.milkbox.net/packages/"))
  (package-initialize))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Paredit
(when (require-maybe 'paredit)
  (defun paredit-on ()
    "Enables paredit and turns off autopair"
    (progn
      (autopair-mode -1)
      (paredit-mode 1))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Autopair
(when (require-maybe 'autopair)
  (autopair-global-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Flymake
(require-maybe 'flymake-cursor) ; display flymake messages in the cmd buffer

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Language Specifics

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; lisp
(defun lispy-hook ()
  "Enable eldoc and paredit"
  (progn
    (interactive)
    (turn-on-eldoc-mode)
    (when-available 'paredit-on
		    (paredit-on))))

(add-hook 'lisp-interaction-mode-hook 'lispy-hook)
(add-hook 'lisp-mode-hook 'lispy-hook)
(add-hook 'emacs-lisp-mode-hook 'lispy-hook)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Clojure
(require-maybe 'clojure-mode)
(require-maybe 'nrepl)

(setq nrepl-popup-stacktraces nil
      nrepl-hide-special-buffers t)

(add-hook 'clojure-mode-hook 'paredit-on)
(add-hook 'nrepl-interaction-mode-hook
	  'nrepl-turn-on-eldoc-mode)
(add-hook 'nrepl-mode-hook 'paredit-on)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Erlang
(add-to-list 'load-path "/usr/local/Cellar/erlang/R16B/lib/erlang/lib/tools-2.6.10/emacs/")
(add-to-list 'exec-path "/usr/local/Cellar/erlang/R16B/lib/erlang/bin/")
(setq erlang-root-dir "/usr/local/Cellar/erlang/R16B/share/")
(add-to-list 'load-path "~/Opt/edts/")

(when (require 'erlang-start)
  (require 'erlang-flymake)
  (require 'edts-start)

  (add-to-list 'auto-mode-alist '("[.]app.src" . erlang-mode))
  (add-to-list 'auto-mode-alist '("Emakefile" . erlang-mode))
  (add-to-list 'auto-mode-alist '("rebar.config" . erlang-mode))
  (add-to-list 'auto-mode-alist '("reltool.config" . erlang-mode))
  (add-to-list 'auto-mode-alist '("sys.config" . erlang-mode))
  (add-to-list 'auto-mode-alist '("vm.args" . erlang-mode)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Latex
(setq TeX-auto-save t
      TeX-parse-self t
      reftex-plug-into-AUCTex t
      TeX-PDF-mode t)
(setq-default TeX-master nil)
(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Markdown
(when (require-maybe 'markdown-mode)
  (add-to-list 'auto-mode-alist '("\\.md" . markdown-mode)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; YAML
(when (require-maybe 'yaml-mode)
  (add-to-list 'auto-mode-alist '("\\.yml" . yaml-mode)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Haskell
(when (require-maybe 'haskell-mode)
  (defun hs-hook ()
    (local-set-key (kbd "RET") 'newline)
    (local-set-key (kbd "C-x C-s") 'haskell-mode-save-buffer))
  (add-hook 'haskell-mode-hook 'hs-hook)
  (require-maybe 'inf-haskell))

(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
(setq haskell-tags-on-save t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Misc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun reload-config ()
  "Reload ~/.emacs"
  (interactive)
  (load-file "~/.emacs"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Vars
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(custom-set-variables
 '(background-color "#7f7f7f")
 '(background-mode dark)
 '(cursor-color "#5c5cff")
 '(custom-enabled-themes (quote (zenburn)))
 '(custom-safe-themes (quote ("36a309985a0f9ed1a0c3a69625802f87dee940767c9e200b89cdebdb737e5b29"
			      "fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6"
			      "1e7e097ec8cb1f8c3a912d7e1e0331caeed49fef6cff220be63bd2a6ba4cc365" default)))
 '(foreground-color "#5c5cff"))
(custom-set-faces)
