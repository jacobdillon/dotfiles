;;; Config for latex modes/tools

(use-package tex
  :ensure auctex
  :config
  (setq TeX-auto-save t
	TeX-parse-self t))

(provide 'init-latex)
