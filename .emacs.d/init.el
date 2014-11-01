;;; init.el --- Contains emacs startup code
;;; Commentary:
;; Loads all emacs customizations.

;;; Code:
(when (version< emacs-version "24.4")
  (error "Please update to a recent version of emacs."))

(setq load-prefer-newer t)

(add-to-list 'load-path (concat user-emacs-directory "core"))
(add-to-list 'load-path (concat user-emacs-directory "modules"))

(when (eq system-type 'darwin)
  (require 'osx-init))

(custom-set-variables
 '(custom-safe-themes
   (quote
    ("3a727bdc09a7a141e58925258b6e873c65ccf393b2240c51553098ca93957723" "756597b162f1be60a12dbd52bab71d40d6a2845a3e3c2584c6573ee9c332a66e" default))))

(require 'packages)
(require 'basics)
(require 'keybinds)

;;; init.el ends here

