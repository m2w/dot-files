;;; beams.el --- Stuff for BEAM languages
;;; Commentary:
;; Contains settings for BEAM VM-based languages.
;;; Code:

(defvar beam-pkgs
  '(edts
    elixir-mode
    erlang))

(ensure-pkgs-installed beam-pkgs)

(defvar erl-release "17.4")
(defvar erl-tools-version "2.7.1")
(defvar erl-root (concat "/usr/local/Cellar/erlang/" erl-release))

(add-to-list 'load-path (concat erl-root "/lib/erlang/lib/tools-" erl-tools-version "/emacs/"))
(add-to-list 'exec-path (concat erl-root "/lib/erlang/bin/"))
(setq-default erlang-root-dir (concat erl-root "/share/"))

(add-to-list 'auto-mode-alist '("[.]app.src" . erlang-mode))
(add-to-list 'auto-mode-alist '("Emakefile" . erlang-mode))
(add-to-list 'auto-mode-alist '("rebar.config" . erlang-mode))
(add-to-list 'auto-mode-alist '("reltool.config" . erlang-mode))
(add-to-list 'auto-mode-alist '("sys.config" . erlang-mode))
(add-to-list 'auto-mode-alist '("vm.args" . erlang-mode))

(require 'erlang-start)

(defun erl-hook ()
  "Enable edts for erlang."
  (require 'edts-start))

;(add-hook 'erlang-mode-hook 'erl-hook)

(require 'elixir-mode)
(add-to-list 'load-path "~/.emacs.d/vendor/alchemist.el/")
(require 'alchemist)

(provide 'beams)
;;; beams.el ends here
