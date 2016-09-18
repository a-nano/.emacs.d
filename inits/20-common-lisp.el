;; Common lisp

;; sbclをデフォルトのCommon Lisp処理系に設定
(setq inferior-lisp-program "sbcl")

;; ~/.emacs.d/slimeをload-pathに追加
(add-to-list 'load-path (expand-file-name "~/.emacs.d/slime-2.18"))

;; SLIMEのロード
(require 'slime)
(slime-setup '(slime-repl slime-fancy slime-banner))

