;;; text.el --- Text editing configuration
;;; Commentary:
;; Contains configurations for plain text and markup languages.
;;; Code:
(defvar text-pkgs
  '(markdown-mode
    adoc-mode))

(ensure-pkgs-installed text-pkgs)

(defun enable-buffer-face ()
  "Enable 'buffer-face-mode'."
  (buffer-face-mode t))

(add-hook 'adoc-mode-hook 'enable-buffer-face)
(add-to-list 'auto-mode-alist (cons "\\.txt\\'" 'adoc-mode))

(defun cust-md-hook ()
  "Provide hooks for `md-mode'."
  (enable-buffer-face)
  (auto-fill-mode))

(add-hook 'markdown-mode-hook 'cust-md-hook)
(add-hook 'gfm-mode-hook 'cust-md-hook)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))

(provide 'text)
;;; text.el ends here
