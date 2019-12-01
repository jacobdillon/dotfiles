(use-package web-mode
  :mode "\\.ts\\'" "\\.html?\\'" "\\.css?\\'" "\\.js\\'"
  :after company
  :config
  (setq web-mode-markup-indent-offset 2
	web-mode-code-indent-offset 2
	web-mode-css-indent-offset 2))

(use-package rainbow-mode)

(provide 'init-web)
