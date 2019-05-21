;;; Config for scheme/racket/related languages

(use-package geiser
  :config
  (setq geiser-active-implementations '(racket))
  (setq geiser-default-implementation 'racket))

(provide 'init-scheme)
