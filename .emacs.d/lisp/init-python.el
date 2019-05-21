;;; Config for Python related modes/tools

(use-package elpy
  :config
  (elpy-enable))

(use-package py-autopep8
  :config
  (add-hook 'python-mode-hook 'py-autopep8-enable-on-save))

(provide 'init-python)
