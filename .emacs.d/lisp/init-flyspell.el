;;; Config for flyspell mode

;; Enable flyspell for various modes
(add-hook 'prog-mode-hook 'flyspell-prog-mode)
(add-hook 'text-mode-hook 'turn-on-flyspell)
(add-hook 'org-mode-hook 'turn-on-flyspell)

(provide 'init-flyspell)
