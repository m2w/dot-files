;;; osx-init.el --- Contains OSX specific fixes
;;; Commentary:
;; OSX specific fixes for emacs.

;;; Code:

;; fix $PATH for emacs
(setenv "PATH" (shell-command-to-string "source $HOME/.bashrc && printf $PATH"))

;; Fix FQDN
(setq system-name (car (split-string system-name "\\.")))

(provide 'osx-init)
;;; osx-init.el ends here
