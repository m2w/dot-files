;;; helmdo.el --- helm and ido config.
;;; Commentary:
;; Contains helm and ido related configuration

;;; Code:

(defvar helmdo-pkgs
  '(helm
    helm-company
    helm-projectile))

(ensure-pkgs-installed helmdo-pkgs)

(require 'helm-config)

(setq helm-quick-update t
      helm-split-window-in-side-p t
      helm-buffers-fuzzy-matching t
      helm-move-to-line-cycle-in-source t
      helm-ff-file-name-history-use-recentf t)

(helm-mode 1)

(eval-after-load 'company
  '(progn
     (define-key company-mode-map (kbd "C-:") 'helm-company)
     (define-key company-active-map (kbd "C-:") 'helm-company)))

(require 'helm-projectile)
(helm-projectile-on)

(provide 'helmdo)
;;; helmdo.el ends here
