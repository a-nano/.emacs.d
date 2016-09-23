;;====================
;; Functions
;;====================
(eval-when-compile
  (require 'cl))

(defun file-name-parent-directory (file-name &optional idx)
  (nth (1+ (or idx 0)) (reverse (split-string file-name "/" t))))

(defun escape-single-quoted (text)
  (replace-regexp-in-string
   "'" "\\\\'" (replace-regexp-in-string "\\\\" "\\\\\\\\" text)))

(defun obarray-to-list (obarray)
  (let (symbols)
    (mapatoms (f_ (push _ symbols))
              obarray)
    symbols))

;;; for Mac
(defun mac-os-p ()
  (member window-system '(mac ns)))
(defun linuxp ()
  (eq window-system 'x))

;; Shell
(defun has-shell-command (command)
  (= 0 (shell-command (format "which %s" command))))

;;====================
;; General
;;====================
(setq eval-expression-print-level nil)

;; exec-path
(loop for x in (reverse
                (split-string (substring (shell-command-to-string "echo $PATH") 0 -1) ":"))
      do (add-to-list 'exec-path x))
(add-to-list 'exec-path "/usr/local/bin")

;; don't kill *scratch*
(defun unkillable-scratch-buffer ()
	(if (equal (buffer-name (current-buffer)) "*scratch*")
	    (progn
	      (delete-region (point-min) (point-max))
	      nil)
      t))
(add-hook 'kill-buffer-query-functions 'unkillable-scratch-buffer)

;; 自分の情報
(setq user-full-name "南尾明栄 (A.Nano)"
      user-mail-address "an74abc@gmail.com")

;; テキストエンコーディングとしてUTF-8を優先使用
(prefer-coding-system 'utf-8)

;; 環境を日本語、UTF-8にする
(set-locale-environment nil)
(set-language-environment "Japanese")
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(prefer-coding-system 'utf-8)

;; 起動時のメッセージを非表示
; (setq inhibit-startup-message t)

;; クリップボードにコピー
(setq x-select-enable-clipboard t)

;; scratchの初期メッセージ消去
(setq initial-scratch-message "")

;; lisp-interaction-modeを使わない
(setq initial-major-mode 'emacs-lisp-mode)

;; Tabの代わりにスペースでインデント
(setq-default tab-width 2
              indent-tabs-mode nil)

;; C-kで行全体を削除
(setq kill-whole-line t)

;; "yes or no"を"y or n"に
(fset 'yes-or-no-p 'y-or-n-p)

;; GCを減らして軽くする
(setq gc-cons-threshold (* 10 gc-cons-threshold))

;; ダイアログを使わない
(setq use-dialog-box nil)
(defalias 'message-box 'message)

;; キーストロークのミニバッファへの表示を早く
(setq echo-keystrokes 0.1)

;; クリップボードにコピー
(setq x-select-enable-clipboard t)

;; 1行ずつスクロール
(setq scroll-conservatively 35
      scroll-margin 0
      scroll-step 1)
(setq comint-scroll-show-maximum-output t) ;; for shell-mode

;; システムのdefault.elを読み込まない
(setq inhibit-default-init t)

;; 最後の行に自動で改行を入れない
(setq-default require-final-newline nil)
(setq require-final-newline nil)

;; beepを消す
(setq ring-bell-function 'ignore)

;; バックアップファイルを作らない
(setq make-backup-files nil)
(setq auto-save-default nil)

;; SQL
(setq sql-user "akihide")
(setq sql-server "localhost")

;; 改行コードを表示する
(setq eol-mnemonic-dos "(CRLF)")
(setq eol-mnemonic-mac "(CR)")
(setq eol-mnemonic-unix "(LF)")

;; ファイルの再読込
(defun revert-buffer-no-confirm (&optional force-reverting)
  "Interactive call to revert-buffer. Ignoring the auto-save
 file and not requesting for confirmation. When the current buffer
 is modified, the command refuses to revert it, unless you specify
 the optional argument: force-reverting to true."
  (interactive "P")
  ;;(message "force-reverting value is %s" force-reverting)
  (if (or force-reverting (not (buffer-modified-p)))
      (revert-buffer :ignore-auto :noconfirm)
    (error "The buffer has been modified")))

;; ファイルの最読込を割当
(define-key global-map "\M-n" 'revert-buffer-no-confirm)
