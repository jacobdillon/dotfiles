;;; Config for wrangling parenthesis and other delimiters

;; Highlight matching parens
(show-paren-mode 1)

(use-package rainbow-delimiters
  :config
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

(use-package smartparens
  :config
  (require 'smartparens-config) ; Base smartparens configuration
  (add-hook 'prog-mode-hook #'smartparens-mode))

(provide 'init-parens)
