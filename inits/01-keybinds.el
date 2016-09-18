;; Command-Key and Option-Key
(when (mac-os-p)
  (setq ns-command-modifier 'meta)
  (setq ns-alternate-modifier 'super)
  (setq mac-pass-command-to-system nil))

;; フォントサイズ変更
(defun font-big ()
 (interactive)
 (set-face-attribute 'default nil :height
  (+ (face-attribute 'default :height) 10))
 (set-jp-font))

(defun font-small ()
 (interactive)
 (set-face-attribute 'default nil :height
  (- (face-attribute 'default :height) 10))
 (set-jp-font))

(defvar maxframe-fullscreen-p nil)

(defun toggle-fullscreen ()
  (interactive)
  (cond
    ((and (mac-os-p) (< emacs-major-version 24)) (ns-toggle-fullscreen))
    ((and (mac-os-p) (require 'maxframe nil t))
     (if maxframe-fullscreen-p (restore-frame) (maximize-frame))
     (setq maxframe-fullscreen-p (not maxframe-fullscreen-p)))
    (t
     (if (frame-parameter nil 'fullscreen)
         (set-frame-parameter nil 'fullscreen nil)
         (set-frame-parameter nil 'fullscreen 'fullboth)))))

(defun define-keys (&optional mode)
  (loop for (key . fn) in my-key-binds
        do (if mode
               (define-key mode key fn)
               (global-set-key key fn))))

(define-keys)

(defun next-file (&optional reversep)
  (let* ((filename (file-name-nondirectory (buffer-file-name)))
         (dirname (file-name-directory (buffer-file-name)))
         (dir-files
          (remove-if (lambda (f) (or (string= f ".")
                                (string= f "..")))
                     (directory-files dirname))))
    (when reversep
      (setq dir-files
            (nreverse dir-files)))
    (loop while dir-files
          for file = (pop dir-files)
          if (string= file filename)
            return (car dir-files))))
(defun open-next-file ()
  (interactive)
  (ari:aif (next-file)
    (find-file it)
    (message "Nothing to see anymore.")))
(defun open-previous-file ()
  (interactive)
  (ari:aif (next-file t)
    (find-file it)
    (message "Nothing to see anymore.")))
(global-set-key (kbd "M-<down>") 'open-next-file)
(global-set-key (kbd "M-<up>") 'open-previous-file)


;;====================
;; Killing
;;====================
;; minibufferでC-wで前の単語を削除
(define-key minibuffer-local-completion-map (kbd "C-w") 'backward-kill-word)

;; 範囲指定していないとき、C-wで前の単語を削除
(defadvice kill-region (around kill-word-or-kill-region activate)
  (if (and (interactive-p) transient-mark-mode (not mark-active))
      (backward-kill-word 1)
    ad-do-it))

;; C-kで行が連結したときにインデントを減らす
(defadvice kill-line (before kill-line-and-fixup activate)
  (when (and (not (bolp)) (eolp))
    (forward-char)
    (fixup-whitespace)
    (backward-char)))

(defadvice kill-sexp (around kill-sexp-and-fixup activate)
  (if (and (not (bolp)) (eolp))
      (progn
        (forward-char)
        (fixup-whitespace)
        (backward-char)
        (kill-line))
      ad-do-it))
