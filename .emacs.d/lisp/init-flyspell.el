;;; Config for flyspell mode

(use-package flyspell
  :config
  (add-hook 'prog-mode-hook 'flyspell-prog-mode)
  (add-hook 'text-mode-hook 'flyspell-mode))
  

(use-package flyspell-correct-ivy
  :after flyspell
  :bind ("C-M-;" . flyspell-correct-wrapper)
  :config
  (setq flyspell-correct-interface #'flyspell-correct-ivy))

(provide 'init-flyspell)
