;; Pathing
(setq root-dir
      (file-name-directory (or load-file-name (buffer-file-name))))

(setq exec-path (append exec-path '("/usr/local/bin")))

(setenv "PATH" (shell-command-to-string "source $HOME/.bashrc && printf $PATH"))

;; Settings
; General
(random t)
(auto-compression-mode t)
(setq save-place t)
(recentf-mode 1)
(setq vc-follow-symlinks t)
(menu-bar-mode -1)

; highlight the current line
(global-hl-line-mode 1)
(set-face-background hl-line-face "gray13")

; auto-fill-mode
(setq comment-auto-fill-only-comments t)
(setq-default auto-fill-function 'do-auto-fill)

; whitespace-mode
(setq whitespace-display-mappings
      '((space-mark 32 [183] [46])
        (newline-mark 10 [182 10])
        (tab-mark 9 [9655 9] [92 9])))
(global-whitespace-mode 1)
(setq-default whitespace-style '(face
                                 trailing
                                 lines
                                 space-before-tab
                                 indentation
                                 space-after-tab)
              whitespace-line-column 80)
(show-paren-mode 1)

(when window-system
  (setq frame-title-format
        '(buffer-file-name "%f" ("%b")))
  (blink-cursor-mode -1)
  (tooltip-mode -1)
  (tool-bar-mode -1))

; Encodings
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(setq visible-bell t
      echo-keystrokes 0.1
      font-lock-maximum-decoration t
      inhibit-startup-message t
      inhibit-splash-screen t
      inhibit-startup-echo-area-message t
      inhibit-scratch-message nil
      transient-mark-mode t
      color-theme-is-global t
      delete-by-moving-to-trash t
      shift-select-mode nil
      truncate-partial-width-windows nil
      uniquify-buffer-name-style 'forward
      make-backup-files nil
      ediff-window-setup-function 'ediff-setup-windows-plain
      xterm-mouse-mode t
      save-place-file (concat user-emacs-directory "places.el"))

; prevent the cursor from moving into the minibuffer prompt
(setq minibuffer-prompt-properties
      (quote
       (read-only
        t
        point-entered
        minibuffer-avoid-prompt
        face
        minibuffer-prompt)))

; ido
(when (> emacs-major-version 21)
  (ido-mode 1)
  (setq ido-enable-prefix nil
        ido-enable-flex-matching t
        ido-create-new-buffer 'always
        ido-use-filename-at-point t
        ido-max-prospects 10)
  (ido-everywhere t))

; sane defaults
(setq require-final-newline t)
(setq next-line-add-newlines nil)
(set-default 'indent-tabs-mode nil)
(set-default 'indicate-empty-lines t)
(set-default 'imenu-auto-rescan t)
(subword-mode 1)
(column-number-mode 1)
(defalias 'yes-or-no-p 'y-or-n-p)

(require 'org)
(require 'cl)
(require 'saveplace)
(require 'ffap)
(require 'uniquify)
(require 'ansi-color)
(require 'recentf)

; Packages
(setq package-archives
      '(("original"    . "http://tromey.com/elpa/")
        ("gnu"         . "http://elpa.gnu.org/packages/")
        ("marmalade"   . "http://marmalade-repo.org/packages/")))
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

; bytecode compilation for elisp
(defun byte-compile-current-buffer ()
  "`byte-compile' current buffer if it's emacs-lisp-mode "
  "and a compiled file exists."
  (interactive)
  (when (and (eq major-mode 'emacs-lisp-mode)
             (file-exists-p (byte-compile-dest-file buffer-file-name)))
    (byte-compile-file buffer-file-name)))

(add-hook 'after-save-hook 'byte-compile-current-buffer)

; Fix for FQDN on OSX
(if (eq system-type 'darwin)
    (setq system-name (car (split-string system-name "\\."))))

(delete 'try-expand-line hippie-expand-try-functions-list)
(delete 'try-expand-list hippie-expand-try-functions-list)

(setq diff-switches "-u")

;; Hooks
(add-hook 'text-mode-hook 'turn-on-auto-fill)
(add-hook 'text-mode-hook 'turn-on-flyspell)
(setq flyspell-issue-welcome-flag nil)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

; eldoc for lispy things
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)

;; Major-Modes
; Diff
(add-to-list 'auto-mode-alist '("COMMIT_EDITMSG$" . diff-mode))
(eval-after-load 'diff-mode
  '(progn
     (set-face-foreground 'diff-added "green4")
     (set-face-foreground 'diff-removed "red3")))

; Magit
(eval-after-load 'magit
  '(progn
     (set-face-foreground 'magit-diff-add "green3")
     (set-face-foreground 'magit-diff-del "red3")))

; Org
(add-hook 'org-mode-hook
          (lambda ()
            (local-set-key "\M-\C-n" 'outline-next-visible-heading)
            (local-set-key "\M-\C-p" 'outline-previous-visible-heading)
            (local-set-key "\M-\C-u" 'outline-up-heading)
            ;; table
            (local-set-key "\M-\C-w" 'org-table-copy-region)
            (local-set-key "\M-\C-y" 'org-table-paste-rectangle)
            (local-set-key "\M-\C-l" 'org-table-sort-lines)
            ;; display images
            (local-set-key "\M-I" 'org-toggle-iimage-in-org)))
(setq org-use-speed-commands t
      org-log-done t)
(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (sh . t)))
(setq org-src-fontify-natively t)
(setq org-src-tab-acts-natively t)


;; Keybindings
(global-set-key (kbd "C-x \\") 'align-regexp)
(global-set-key (kbd "M-/") 'hippie-expand)

(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "\C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)

(windmove-default-keybindings) ;; Shift+direction
(global-set-key (kbd "C-x O")
                (lambda ()
                  (interactive) (other-window -1))) ;; back one
(global-set-key (kbd "C-x C-o")
                (lambda ()
                  (interactive) (other-window 2))) ;; forward two

(global-set-key (kbd "C-x ^") 'join-line)

(global-set-key (kbd "C-h a") 'apropos)

(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-x\C-r" 'rgrep)

;; Theming
(load-theme 'wombat t)
; fix hl-line after theming
(set-face-attribute 'highlight nil :foreground 'unspecified)
;; TODO move this to a seperate file

; CSS
(add-to-list 'auto-mode-alist '("\\.css$" . css-mode))
(require 'flymake-sass)
(add-to-list 'auto-mode-alist '("\\.scss$" . scss-mode))

; JS
(require 'js2-mode)
(require 'flymake-jslint)
(require 'flymake-jshint)
(add-to-list 'auto-mode-alist '("\\.js\\(on\\)?$" . js2-mode))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
