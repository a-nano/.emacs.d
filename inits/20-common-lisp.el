;; Common lisp

;; SLIMEのロード
(require 'slime)
(require 'ac-slime)

;; sbclをデフォルトのCommon Lisp処理系に設定
(setq inferior-lisp-program "sbcl")
(setq slime-contribs '(slime-fancy))


; (slime-setup '(slime-repl slime-fancy slime-banner slime-fuzzy slime-highlight-edits))
(add-hook 'lisp-mode-hook 'slime-mode)
(add-hook 'lisp-mode-hook 'rainbow-delimiters-mode)
(add-hook 'slime-mode-hook 'set-up-slime-ac)
(add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'slime-repl-mode))
