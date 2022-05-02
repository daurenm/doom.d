;;; +org.el -*- lexical-binding: t; -*-

(setq org-directory "~/org/")

;; jump between headings
(map! (:after evil-org
       :map evil-org-mode-map
       :n "gk" (cmd! (if (org-on-heading-p)
                         (org-backward-element)
                       (evil-previous-visual-line)))
       :n "gj" (cmd! (if (org-on-heading-p)
                         (org-forward-element)
                       (evil-next-visual-line)))))

(after! org
  (setq org-todo-keywords '((sequence "TODO(t)" "BLOCKED(b)" "|" "DONE(d)" "CANCELLED(c)")
                            (sequence "[ ](T)" "[-](S)" "[?](W)" "|" "[X](D)"))
        ;; org-todo-keyword-faces '(("BLOCKED" . +org-todo-onhold),
        ;;                          ("DONE" . +org-todo-active)))
        org-todo-keyword-faces '(("[-]" . +org-todo-active)
                                 ("[?]" . +org-todo-onhold)
                                 ("BLOCKED" . +org-todo-onhold))))
