;;; Company config

;; company
(use-package company
  :config
  (add-hook 'after-init-hook 'global-company-mode))

(provide 'init-company)
