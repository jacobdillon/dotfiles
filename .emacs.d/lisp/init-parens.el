;;; Config for wrangling parenthesis and other delimiters

;; Highlight matching parens
(show-paren-mode 1)

(use-package rainbow-delimiters
  :config
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

(use-package smartparens
  :config
  (require 'smartparens-config) ; Base smartparens configuration
  (add-hook 'prog-mode-hook #'smartparens-mode)
  (setq-default sp-escape-quotes-after-insert nil)) ; Fix for cc-mode

(provide 'init-parens)
