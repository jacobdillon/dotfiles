;;; Config for latex modes/tools

(use-package tex
  :ensure auctex
  :config
  (setq TeX-auto-save t
	TeX-parse-self t
	TeX-save-query nil))

(use-package auctex-latexmk
  :after tex
  :config
  (auctex-latexmk-setup)
  (defun my-tex-set-latexmk-as-default ()
    (setq TeX-command-default "LatexMk"))
  (add-hook 'tex-mode-hook #'my-tex-set-latexmk-as-default)
  (setq auctex-latexmk-inherit-TeX-PDF-mode t))

(provide 'init-latex)
