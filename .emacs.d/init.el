;;; init.el

;; Add ~/.emacs.d/lisp/ to the load-path (where all the goodies are)
(add-to-list 'load-path "~/.emacs.d/lisp/")

;; package.el and use-package initialization
(require 'init-package)

;; Mode inits
(require 'init-company)
(require 'init-custom)
(require 'init-flycheck)
(require 'init-flyspell)
(require 'init-general)
(require 'init-git)
(require 'init-haskell)
(require 'init-ivy)
(require 'init-latex)
(require 'init-parens)
(require 'init-projectile)
(require 'init-python)
(require 'init-rust)
(require 'init-scheme)
(require 'init-theme)
