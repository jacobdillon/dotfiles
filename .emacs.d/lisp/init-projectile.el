;;; Config for projectile mode

(use-package projectile
  :config
  (setq projectile-project-search-path '("~/src"))
  (projectile-mode +1))

(provide 'init-projectile)
