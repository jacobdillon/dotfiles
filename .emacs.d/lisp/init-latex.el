;;; Config for latex modes/tools

(use-package tex-site
  :ensure auctex
  :mode ("\\.tex\\'" . latex-mode)
  :config
  (add-hook 'LaTeX-mode-hook (lambda () (setq TeX-auto-save t
					      TeX-parse-self t
					      TeX-PDF-mode t))))

(use-package auctex-latexmk
  :after auctex
  :config
  (auctex-latexmk-setup)
  (add-hook 'LaTeX-mode-hook (lambda () (setq TeX-command-default "LatexMk")))
  (setq auctex-latexmk-inherit-TeX-PDF-mode t))

(provide 'init-latex)
