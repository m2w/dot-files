;;; lisps.el --- Lisp specific stuff
;;; Commentary:
;; Contains settings for lisps.
;;; Code:

(defun byte-compile-current-buffer ()
  "Bytecompile the current buffer."
  (add-hook 'after-save-hook
            (when (and
                   (string-prefix-p user-emacs-directory
                                    (file-truename buffer-file-name))
                   (file-exists-p (byte-compile-dest-file buffer-file-name)))
              (emacs-lisp-byte-compile))
            nil t))

(defun elisp-hooks ()
  "Provide all elisp hooks."
;  (byte-compile-current-buffer)
  (smartparens-strict-mode 1)
  (run-hooks 'turn-on-eldoc-mode))

(add-hook 'emacs-lisp-mode-hook 'elisp-hooks)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)

(defvar lispy-pkgs
  '(cider
    clojure-mode))

(ensure-pkgs-installed lispy-pkgs)

(require 'clojure-mode)
(require 'cider)

(setq nrepl-hide-special-buffers t)
(setq cider-repl-pop-to-buffer-on-connect nil)
(setq cider-auto-select-error-buffer nil)

(defun cider-hooks ()
  "Provide all cider hooks."
  (smartparens-strict-mode 1)
  (subword-mode 1)
  (run-hooks 'cider-turn-on-eldoc-mode))

(add-hook 'cider-mode-hook 'cider-hooks)
(add-hook 'cider-repl-mode-hook 'cider-hooks)

(provide 'lisps)
;;; lisps.el ends here
