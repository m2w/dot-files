;;; go.el --- Go specific stuff
;;; Commentary:
;; Contains settings for go.
;;; Code:
(defvar go-packages
  '(company-go
    go-eldoc
    go-mode
    go-projectile
    gotest))

(ensure-pkgs-installed go-packages)

(require 'go-projectile)
(add-to-list 'completion-ignored-extensions ".test")

(defun go-hooks ()
  "Provide all go hooks."
  (add-hook 'before-save-hook 'gofmt-before-save nil t)
  (whitespace-toggle-options '(tabs))
  (go-eldoc-setup)
  (set (make-local-variable 'company-backends) '(company-go))
  (subword-mode 1))

(add-hook 'go-mode 'go-hooks)

(provide 'go)
;;; go.el ends here
