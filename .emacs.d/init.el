;;; init.el

;; REMOVE THIS GARBAGE SOON WHEN BUG IS FIXED
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

;; Add ~/.emacs.d/lisp/ to the load-path (where all the goodies are)
(add-to-list 'load-path "~/.emacs.d/lisp/")

;; package.el and use-package initialization
(require 'init-package)

;; Mode inits
(require 'init-c)
(require 'init-company)
(require 'init-dired)
(require 'init-direnv)
(require 'init-flycheck)
(require 'init-flyspell)
(require 'init-general)
(require 'init-git)
(require 'init-ivy)
(require 'init-latex)
(require 'init-nix)
(require 'init-parens)
(require 'init-python)
(require 'init-theme)
(require 'init-web)
