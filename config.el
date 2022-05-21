;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Dauren Muratov"
      user-mail-address "dauren.ktl@gmail.com")

;; (setq doom-font (font-spec :family "SauceCodePro Nerd Font" :size 14 :weight 'regular))
(setq doom-font (font-spec :family "JetBrains Mono" :size 14 :weight 'regular)
      doom-theme 'doom-nord
      display-line-numbers-type nil)

(setq-default tab-width 2)
(setq +zen-text-scale 0)

;; Look for projects in a specific folder
(setq projectile-project-search-path '("~/Documents/dev/" "~/org"))

;; Make (-) be a part of word,
;; allows for easier movement/selection/deletion
(with-eval-after-load 'evil
    (defalias #'forward-evil-word #'forward-evil-symbol)
    ;; make evil-search-word look for symbol rather than word boundaries
    (setq-default evil-symbol-word-search t))

;;; :editor evil
;; Focus new window after splitting
(setq evil-split-window-below t
      evil-vsplit-window-right t)

;; display company docs faster (default is 0.5)
(setq company-box-doc-delay 0.3)

;; setup TERM when for KITTY
(setq vterm-term-environment-variable "xterm-kitty")
;;
;;; Keybinds

(map!
 :n ", ," #'save-buffer
 :leader "w f" #'doom/window-maximize-buffer)

(define-key global-map (kbd "C-c M-3") (lambda () (interactive) (insert "£")))

(map! :map general-override-mode-map
      :ei "C-d" #'delete-forward-char)

(load! "+org")
(load! "+acm")

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
