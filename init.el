(setq load-path (cons"~/.emacs.d/elisp" load-path))
(require 'init-loader)
(setq init-loader-show-log-after-init nil)
(init-loader-load)
