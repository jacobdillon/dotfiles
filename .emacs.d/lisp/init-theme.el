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
(set-frame-font "Go Mono 12" nil t)

;; Theme settings
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'taffy t)

(provide 'init-theme)
