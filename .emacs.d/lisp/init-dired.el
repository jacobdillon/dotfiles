;;; Dired configuration

(use-package dired
  :ensure nil
  :hook (dired-mode . dired-hide-details-mode)
  :config
  (use-package dired-git-info
    :bind (:map dired-mode-map (")" . dired-git-info-mode))))

(provide 'init-dired)
