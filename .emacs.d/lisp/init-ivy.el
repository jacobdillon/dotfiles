;;; Config for ivy/counsel/etc.

(use-package ivy
  :demand
  :config
  (setq ivy-use-virtual-buffers t
	ivy-count-format "%d/%d ")
  (ivy-mode 1))

(use-package counsel
  :after ivy
  :config
  (global-set-key (kbd "M-x") 'counsel-M-x)
  (global-set-key (kbd "C-x C-m") 'counsel-M-x)
  (global-set-key (kbd "C-x C-f") 'counsel-find-file)
  (global-set-key (kbd "<f2> u") 'counsel-unicode-char))

(provide 'init-ivy)
