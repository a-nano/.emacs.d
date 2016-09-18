;; 選択範囲をハイライト
(setq-default transient-mark-mode t)

;; バッファ一覧を詳細に
(global-set-key "\C-x\C-b" 'bs-show)

;; 対応するカッコをハイライト
(show-paren-mode t)

;; 行数を表示
(global-linum-mode t)

;; カーソル行をハイライト
(defface hlline-face
  '((((class color)
      (background dark))
     (:background "dark slate gray"))
    (((class color)
      (background light))
     (:background "ForestGreen"))
    (t
     ()))
  nil :group 'font-lock-highlighting-faces)
(setq hl-line-face 'hlline-face)
(global-hl-line-mode)

;; モード行に行番号、桁番号を表示
(line-number-mode t)
(column-number-mode t)

;; モード行に時刻を表示
(setq display-time-string-forms '(24-hours ":" minutes))
(display-time)

;; モード行にバッテリ残量を表示
(when (and (require 'battery nil t)
           battery-status-function
           (not (string-match-p "N/A"
                                (battery-format "%B"
                                                (funcall battery-status-function)))))
  (display-battery-mode t))

;; 改行コードを表示
(setq eol-mnemonic-dos "(CRLF)"
      eol-mnemonic-mac "(CR)"
      eol-mnemonic-unix "(LF)")

;; 行間を開く
(setq-default line-spacing 0.1)

;; スペース、タブを可視化する
(setq scroll-conservatively 1)

;;====================
;; Window System
;;====================

;; ウインドウを透明にする
;; アクティブウインドウ/非アクティブウインドウ(alphaの値で透明度を指定)
(add-to-list 'default-frame-alist '(alpha . (0.85 0.85)))

;; 画面の色を設定
(if window-system
    (progn
      ;; 文字の色を設定
      (add-to-list 'default-frame-alist '(foreground-color . "white"))
      ;; 背景色を設定
      (add-to-list 'default-frame-alist '(background-color . "black"))
      ;; カーソルの色を設定
      (add-to-list 'default-frame-alist '(cursor-color . "gray9"))))

;; Emacs serverを起動
(server-start)

;; フレームを透過
(set-frame-parameter nil 'alpha 85)

;; メニューバーを消す
; (menu-bar-mode -1)

;; ツールバーを消す
(tool-bar-mode -1)
(toggle-scroll-bar nil)

;; スクロールバーを非表示
(set-scroll-bar-mode nil)