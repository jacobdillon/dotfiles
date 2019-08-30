;;; Config/initialization of package.el and related tools

(require 'package)

;; Initilize package
(setq package-enable-at-startup nil)
(unless package--initialized (package-initialize))

;; Add package repos
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)

;; Bootstrap and enable use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))

;; Always ensure package installation
(setq use-package-always-ensure t)

(provide 'init-package)
