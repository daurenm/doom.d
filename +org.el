;;; +org.el -*- lexical-binding: t; -*-

(setq org-directory "~/org/"
      org-archive-location (concat org-directory ".archive/%s::"))

;; (setq org-time-stamp-custom-formats '("<%d.%m %a>" . "<%d.%m %a %H:%M>")) ; european
;; (setq org-time-stamp-custom-formats '("<%m-%d %a>" . "<%m-%d %a %H:%M>")) ; american (ISO)
;; (setq org-display-custom-times t)

;; jump between headings
(map! (:after evil-org
       :map evil-org-mode-map
       :n "gk" (cmd! (if (org-on-heading-p)
                         (org-backward-element)
                       (evil-previous-visual-line)))
       :n "gj" (cmd! (if (org-on-heading-p)
                         (org-forward-element)
                       (evil-next-visual-line)))
       :n "z o" #'org-show-subtree))

;; (setq org-agenda-custom-commands
;;       '(("n" "Agenda and all TODOs"
;;          ((agenda "")
;;           (alltodo ""))))

(after! org
  (setq org-startup-folded 'show2levels
        org-ellipsis " [...] "
        org-todo-keywords '((sequence "TODO(t)" "MISC(m)" "HOLD(h)" "|" "DONE(d)" "KILL(k)"))
        org-todo-keyword-faces '(("MISC" . org-cite)
                                 ("HOLD" . org-warning))
        org-hide-emphasis-markers t
        org-capture-templates
        '(("t" "todo" entry (file+headline "todo.org" "Inbox")
           ;; "* TODO %?\n%i\n%a"
           "* TODO %?"
           :prepend t)
          ("d" "deadline" entry (file+headline "todo.org" "Scheduled")
           ;; "* TODO %?\nDEADLINE: <%(org-read-date)>\n\n%i\n%a"
           "* TODO %?\nDEADLINE: <%(org-read-date)>\n"
           :prepend t)
          ("s" "schedule" entry (file+headline "todo.org" "Scheduled")
           ;; "* TODO %?\nSCHEDULED: <%(org-read-date)>\n\n%i\n%a"
           "* TODO %?\nSCHEDULED: <%(org-read-date)>\n"
           :prepend t)
          ("c" "later" entry (file+headline "todo.org" "Later")
           ;; "* [ ] %?\n%i\n%a"
           "* [ ] %?"
           :prepend t)))

  (map! :n ", a" #'org-agenda
        :n ", t" (cmd! (org-agenda nil "n"))
        :n ", d" #'org-check-deadlines
        :ne "C-c l" #'org-store-link
        :map general-override-mode-map "C-c ," #'org-time-stamp-inactive))
