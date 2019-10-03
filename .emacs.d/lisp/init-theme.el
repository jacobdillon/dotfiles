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
;(use-package solarized-theme
;  :config
;  (load-theme 'solarized-dark t)
;  (setq solarized-use-variable-pitch nil
;	x-underline-at-descent-line t
;	solarized-scale-org-headlines nil
;	solarized-emphasize-indicators nil
;	solarized-high-contrast-mode-line t)
;  (defun toggle-bg ()
;    "Toggles from dark to light background (and vice-versa)"
;    (interactive)
;    (if (eq (frame-parameter (next-frame) 'background-mode) 'dark)
;	(progn
;	  ;; Light Mode
;	  (disable-theme 'solarized-dark)
;	  (load-theme 'solarized-light t))
;      ;; Dark Mode
;      (disable-theme 'solarized-light)
;      (load-theme 'solarized-dark t)))
;  (global-set-key (kbd "<f5>") 'toggle-bg))

(provide 'init-theme)
