;;; Config for Haskell related modes/tools

;; Run `cabal install happy hindent' in order to use these modes.

(use-package haskell-mode)

(use-package hindent
  :config
  (add-hook 'haskell-mode-hook #'hindent-mode))

(provide 'init-haskell)
