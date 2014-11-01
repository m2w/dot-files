;;; basics.el --- Contains sane defaults
;;; Commentary:
;; Provides defaults for editing and look and feel.

;;; Code:

;; seed the random number generator
(random t)

;; always highlight the current line
(global-hl-line-mode +1)

;; delete current selection on keypress
(delete-selection-mode t)

;; force a final \n on buffers
(setq require-final-newline t)

;; do not endlessly add newlines from next-line
(setq next-line-add-newlines nil)

;; use spaces for indentation
(set-default 'indent-tabs-mode nil)

;; use tabs for indentation or completion
(setq tab-always-indent 'complete)

;; buffers should always reflect their underlying file
(global-auto-revert-mode t)

;; reduce verbosity on yes/no questions
(defalias 'yes-or-no-p 'y-or-n-p)

;; ensure we use UTF8 throughout
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; configure smartparens
(require 'smartparens-config)
(setq sp-autoskip-closing-pair 'always)
(setq sp-hybrid-kill-entire-symbol nil)
(show-smartparens-global-mode 1)

;; ensure buffers have meaningfull names
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)
(setq uniquify-ignore-buffers-re "^\\*")

;; disable the useless menu-bar
(menu-bar-mode -1)

;; decompress/compress files on the fly
(auto-compression-mode t)

;; enable mouse support in emacs
(xterm-mouse-mode t)

;; disable backup files
(setq make-backup-files nil)

;; follow symlinks into vc'ed files
(setq vc-follow-symlinks t)

;; when running with a window system, disable cursor blinking,
;; tooltips and the toolbar
(when window-system
  (setq frame-title-format
        '(buffer-file-name "%f" ("%b")))
  (blink-cursor-mode -1)
  (tooltip-mode -1)
  (tool-bar-mode -1))

;; self-explanatory improvements
(setq visible-bell t
      inhibit-startup-message t
      inhibit-splash-screen t
      inhibit-startup-echo-area-message t
      initial-scratch-message ";;; May the force be with you!\n"
      transient-mark-mode t
      diff-switches "-u")

;; setup aspell
(require 'flyspell)
(setq ispell-program-name "aspell"
      ispell-extra-args '("--sug-mode=ultra"
                          "--run-together-limit=3"
                          "--run-together-min=2")
      flyspell-issue-welcome-flag nil)

(defun enable-flyspell ()
  "Enable flyspell when the required executable can be found."
  (when (executable-find ispell-program-name)
    (flyspell-mode +1)))

(add-hook 'text-mode-hook 'enable-flyspell)

;; always cleanup whitespace
(setq whitespace-style '(trailing face))
(setq whitespace-line-column 80)
(add-hook 'before-save-hook 'whitespace-cleanup)

(set-default 'imenu-auto-rescan t)

;; tramp for sudo
(require 'tramp)
(setq tramp-default-method "ssh")

;; ensure the minibuffer prompt remains untouchable
(setq minibuffer-prompt-properties
       '(read-only t
         point-entered minibuffer-avoid-prompt
         face minibuffer-prompt))

;; remember where we left off in files
(require 'saveplace)
(setq save-place-file (concat user-emacs-directory "saveplace"))
(setq-default save-place t)

(require 'windmove)
(windmove-default-keybindings)

;; collapse minor modes
(require 'diminish)
;; TODO: check which modes should be diminished/abbreviated

;; prettify the smart-mode-line
(require 'smart-mode-line)
(sml/setup)
(sml/apply-theme 'respectful)

;; setup projectile
(require 'projectile)
(setq projectile-cache-file (concat user-emacs-directory "projectile.cache"))
(projectile-global-mode t)

;; setup company for autocompletion
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)

;; use the wombat theme
(load-theme 'wombat t)
; fix hl-line after theming
(set-face-attribute 'highlight nil :foreground 'unspecified)

;; TODO: ido!

(provide 'basics)
;;; basics.el ends here
