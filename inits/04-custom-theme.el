;; 括弧の色を薄く
(defvar paren-face 'paren-face)
(make-face 'paren-face)
(set-face-foreground 'paren-face "#dcdcdc")

(dolist (mode '(lisp-mode
                cl21-mode
                emacs-lisp-mode
                scheme-mode))
  (font-lock-add-keywords mode
                          '(("(\\|)" . paren-face))))
