;;; packages.el --- Contains essential packages.
;;; Commentary:
;; Provides essential packages and package installation.

;;; Code:
(require 'package)

(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(defvar basic-packages
  '(company
    diminish
    flycheck
    git-commit-mode
    gitconfig-mode
    gitignore-mode
    magit
    projectile
    smart-mode-line
    smartparens
    sublime-themes))

(defun ensure-pkg-installed (pkg)
  "Ensure that PKG is installed."
  (unless (package-installed-p pkg)
    (package-install pkg)))

(defun ensure-pkgs-installed (pkgs)
  "Ensures that all PKGS are installed."
  (mapc #'ensure-pkg-installed pkgs))

;; Install any missing packages
(ensure-pkgs-installed basic-packages)

;; TODO: add a function to ensure flycheck/company-mode backends are present
;; for most necessary languages?

(provide 'packages)
;;; packages.el ends here
