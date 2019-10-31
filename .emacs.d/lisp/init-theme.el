;;; Configuration for theme/GUI options

;; Disable the toolbar, menubar, and scrollbar
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;; Set window title to the buffer name
(setq-default frame-title-format '("%b"))

;; Show column number in modeline
(column-number-mode 1)

;; Display line numbers in all programming modes
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; Fontface
(set-frame-font "Iosevka Type 12" nil t)

;; Theme settings
(use-package dracula-theme
  :config
  (load-theme 'dracula t))

(provide 'init-theme)
