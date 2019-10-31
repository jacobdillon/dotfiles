;;; Config for flyspell mode

(use-package flyspell
  :config
  (flyspell-mode 1))

(use-package flyspell-correct-ivy
  :after flyspell
  :bind ("C-M-;" . flyspell-correct-wrapper)
  :config
  (setq flyspell-correct-interface #'flyspell-correct-ivy))

(provide 'init-flyspell)
