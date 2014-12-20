;;; webthings.el --- Stuff for web development
;;; Commentary:
;; Contains settings for web/frontend related modes.
;;; Code:

(defvar web-pkgs
  '(haml-mode
    js2-mode
    json-mode
    jsx-mode
    json-reformat
    sass-mode
    web-mode))

(ensure-pkgs-installed web-pkgs)

(setq web-mode-markup-indent-offset 2
      web-mode-enable-current-element-highlight t
      web-mode-enable-comment-keywords t
      web-mode-enable-auto-pairing t
      web-mode-enable-css-colorization t)

(defun cust-web-hook ()
  "Provide hooks for `web-mode'."
  (subword-mode 1))

(add-hook 'web-mode-hook 'cust-web-hook)
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))

(provide 'webthings)
;;; webthings.el ends here
