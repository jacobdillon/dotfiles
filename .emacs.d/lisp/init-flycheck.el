;;; Config for Flycheck mode

;; Make sure to install syntax checking programs:
;; `pip install pylint', `npm install eslint', etc.

(use-package flycheck
  :config
  (add-hook 'prog-mode-hook 'flycheck-mode)
  (with-eval-after-load 'flycheck
    (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc)))
  (define-fringe-bitmap 'my-flycheck-fringe-indicator
    (vector #b00000000
	    #b00000000
	    #b00000000
	    #b00000000
	    #b00000000
	    #b00000000
	    #b00000000
	    #b00011100
	    #b00111110
	    #b00111110
	    #b00111110
	    #b00011100
	    #b00000000
	    #b00000000
	    #b00000000
	    #b00000000
	    #b01111111))
  (flycheck-define-error-level
   'error
   :overlay-category 'flycheck-error-overlay
   :fringe-bitmap 'my-flycheck-fringe-indicator
   :fringe-face 'flycheck-fringe-error)
  (flycheck-define-error-level
   'warning
   :overlay-category 'flycheck-warning-overlay
   :fringe-bitmap 'my-flycheck-fringe-indicator
   :fringe-face 'flycheck-fringe-warning)
  (flycheck-define-error-level
   'info
   :overlay-category 'flycheck-info-overlay
   :fringe-bitmap 'my-flycheck-fringe-indicator
   :fringe-face 'flycheck-fringe-info))

(provide 'init-flycheck)
