;;; Config for custom (don't use it)

;; Set customize to save to an external file and load it
(setq custom-file "~/.emacs.d/custom.el")
(unless (file-exists-p custom-file)
  (write-region "" nil custom-file))
(load custom-file)

(provide 'init-custom)
