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

;; European format for dates
;; (setq org-time-stamp-custom-formats '("<%d/%m/%y %a>" . "<%d/%m/%y %a %H:%M>"))
(setq org-time-stamp-custom-formats '("<%d.%m %a>" . "<%d.%m %a %H:%M>"))
(setq org-display-custom-times t)

(after! org
  (setq org-todo-keywords '((sequence "TODO(t)" "HOLD(h)" "|" "DONE(d)" "KILL(k)")))
  (map! :n ", a" #'org-agenda
        :map general-override-mode-map "C-c C-w" #'org-check-deadlines))
