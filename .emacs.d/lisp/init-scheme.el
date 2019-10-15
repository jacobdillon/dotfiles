;;; Config for scheme/racket/related languages

(use-package geiser
  :config
  (setq geiser-active-implementations '(racket chicken))
  (setq geiser-default-implementation 'chicken))

(provide 'init-scheme)
