;;; text.el --- Text editing configuration
;;; Commentary:
;; Contains configurations for plain text and markup languages.
;;; Code:
(defvar text-pkgs
  '(markdown-mode
    adoc-mode))

(ensure-pkgs-installed text-pkgs)

(defun enable-buffer-face ()
  "Enable buffer-face-mode."
  (buffer-face-mode t))

(add-hook 'adoc-mode-hook 'enable-buffer-face)
(add-to-list 'auto-mode-alist (cons "\\.txt\\'" 'adoc-mode))

(add-hook 'markdown-mode-hook 'enable-buffer-face)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))

(provide 'text)
;;; text.el ends here
