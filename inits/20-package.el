;; use package

(require 'cl)

(defvar installing-package-list
  '(
    ;; ここに使っているパッケージを書く。
    slime
    ac-slime
    auto-complete
    macrostep
    popup
    smart-cursor-color
    clojure-mode
    cider
    ))

(let ((not-installed (loop for x in installing-package-list
                            when (not (package-installed-p x))
                            collect x)))
  (when not-installed
    (package-refresh-contents)
    (dolist (pkg not-installed)
        (package-install pkg))))
