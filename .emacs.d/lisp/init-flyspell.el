;;; Config for flyspell mode

(setq ispell-program-name "aspell"
      ispell-dictionary "english")

;; Enable flyspell for various modes
(add-hook 'prog-mode-hook 'flyspell-prog-mode)
(add-hook 'text-mode-hook 'turn-on-flyspell)
(add-hook 'org-mode-hook 'turn-on-flyspell)
(add-hook 'LaTeX-mode-hook 'turn-on-flyspell)

(provide 'init-flyspell)
