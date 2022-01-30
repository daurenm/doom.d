;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Dauren Muratov"
      user-mail-address "dauren.ktl@gmail.com")

;; (setq doom-font (font-spec :family "SauceCodePro Nerd Font" :size 14 :weight 'regular))
(setq doom-font (font-spec :family "JetBrains Mono" :size 14 :weight 'regular)
      doom-theme 'doom-nord)

(setq display-line-numbers-type nil)

;; Look for projects in a specific folder
(setq projectile-project-search-path '("~/Documents/dev/"))

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

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

;;
;;; Keybinds

(map!
 :n ", ," #'save-buffer
 :n ", q" #'kill-current-buffer

 :leader "w f" #'doom/window-maximize-buffer)


;;
;;; Codeforces Config
(setq flycheck-c/c++-gcc-executable "g++-11")
(setq flycheck-disabled-checkers '(c/c++-clang))
(setq compile-command "make -B ")

(defun compile-cpp-advanced ()
  (interactive)

  ;;; saved for learning...
  ;; (set (make-local-variable 'compile-command)
  ;;    (let ((file (file-name-nondirectory buffer-file-name)))
  ;;      (format "g++-11 -Wall -Wextra -Wshadow -Werror -O2 -o %s %s && ./%s < input\n"
  ;;          (file-name-sans-extension file)
  ;;          file
  ;;          (file-name-sans-extension file))))
  ;; (compile compile-command)

  (defvar makefile)
  (setq makefile (concat "make -B " (file-name-base) "\n"))
  ;; buffer-name -> file name
  ;; file-name-base -> file name w/o extension
  (compile makefile)

  ;; running as a shell command
  ;; (shell-command makefile)

  ;; reload all buffers
  (global-auto-revert-mode))

(defun makefile-cpp ()
  (interactive)
  (if (string-match-p "cpp" (buffer-name))
      (compile-cpp-advanced)
    (recompile)))

(defun compile-cpp-default ()
  (interactive)
  (unless (file-exists-p "Makefile")
    (set (make-local-variable 'compile-command)
     (let ((file (file-name-nondirectory buffer-file-name)))
       (format "g++-11 -Wall -Wextra -Wshadow -O2 -o %s %s && ./%s < input\n"
           (file-name-sans-extension file)
           file
           (file-name-sans-extension file))))
    (compile compile-command)))

(map! :n ", c" #'makefile-cpp)

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
