(use-package lsp-mode
  :hook (prog-mode . lsp))

(use-package lsp-ui
  :after lsp-mode)

(use-package company-lsp
  :after lsp-mode
  :after company)

(provide 'init-lsp)
