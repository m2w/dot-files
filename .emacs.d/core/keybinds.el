;;; keybinds.el --- Global keybindings
;;; Commentary:
;; Contains global keybindings.

;;; Code:
(global-set-key (kbd "C-x \\") 'align-regexp)
(global-set-key (kbd "M-/") 'hippie-expand)

(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "\C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)

(global-set-key (kbd "C-x O")
                (lambda ()
                  (interactive) (other-window -1))) ;; back one
(global-set-key (kbd "C-x C-o")
                (lambda ()
                  (interactive) (other-window 2))) ;; forward two
(global-set-key (kbd "C-x C-b") 'buffer-menu)
(global-set-key (kbd "C-x ^") 'join-line)

(global-set-key (kbd "C-h a") 'apropos)

(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-x\C-r" 'rgrep)

(defun complete-or-indent ()
  "Either indent or complete at point."
  (interactive)
  (if (looking-at "\\_>")
      (helm-company)
    (indent-according-to-mode)))
(define-key global-map "\t" 'complete-or-indent)

(provide 'keybinds)
;;; keybinds.el ends here
