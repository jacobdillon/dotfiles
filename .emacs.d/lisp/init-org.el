;;; Config for org-mode

(use-package org
  :config
  (setq org-agenda-files (list "~/Documents/todo.org")
	org-fontify-whole-heading-line t
	org-src-fontify-natively t
	org-log-done t)
  (add-hook 'org-mode-hook 'turn-on-auto-fill)
  (global-set-key (kbd "C-c l") 'org-store-link)
  (global-set-key (kbd "C-c a") 'org-agenda))

(provide 'init-org)
