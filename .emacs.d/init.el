;;; init.el --- Contains emacs startup code
;;; Commentary:
;; Loads all emacs customizations.

;;; Code:
(when (version< emacs-version "24.4")
  (error "Please update to a recent version of Emacs"))

(setq load-prefer-newer t)

(add-to-list 'load-path (concat user-emacs-directory "core"))
(add-to-list 'load-path (concat user-emacs-directory "modules"))

(when (eq system-type 'darwin)
  (require 'osx-init))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(custom-safe-themes
   (quote
    ("c5a044ba03d43a725bd79700087dea813abcb6beb6be08c7eb3303ed90782482" "3b819bba57a676edf6e4881bd38c777f96d1aa3b3b5bc21d8266fa5b0d0f1ebf" "3a727bdc09a7a141e58925258b6e873c65ccf393b2240c51553098ca93957723" "756597b162f1be60a12dbd52bab71d40d6a2845a3e3c2584c6573ee9c332a66e" default)))
 '(rm-blacklist (quote (" hl-p" " Helm" " company" " ELDoc")))
 '(sml/modified-char "*"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background nil))))
 '(cider-error-highlight-face ((t (:background "color-233" :foreground "magenta"))))
 '(flycheck-error ((t (:background "color-233" :foreground "magenta" :weight bold))))
 '(flycheck-warning ((t (:foreground "magenta"))))
 '(hl-line ((t (:background "#424242")))))

(require 'packages)
(require 'helmdo)
(require 'basics)
(require 'keybinds)

(require 'lisps)
(require 'golang)
(require 'text)
(require 'beams)
(require 'webthings)

;;; init.el ends here

