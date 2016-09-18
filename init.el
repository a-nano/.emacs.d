(setq load-path (cons"~/.emacs.d/elisp" load-path))

(package-initialize)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)

(require 'init-loader)
(setq init-loader-show-log-after-init nil)
(init-loader-load)

