;;; +acm.el -*- lexical-binding: t; -*-

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

(defun makefile-clean-cpp ()
  (interactive)
  (compile "make clean")
  (global-auto-revert-mode))

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
(map! :n ", n" #'makefile-clean-cpp)
