;;; General configuration

;; Set personal information
(setq user-full-name "Jacob Dillon"
      user-mail-address "jacob.dillon@uconn.edu"
      calendar-latitude 41.81
      calendar-longitude -72.25
      calendar-location-name "Storrs, CT")

;; Set the default gc threshold to 16MB
(setq gc-cons-threshold 16777216
      garbage-collection-messages nil)

;; Avoid outdated files from being loaded
(setq load-prefer-newer t)

;; Use y and n instead of yes and no
(defalias 'yes-or-no-p 'y-or-n-p)

;; Don't use customize
(setq custom-file "")

;; Turn off the splash screen
(setq inhibit-startup-screen t
      initial-scratch-message "")

;; Create backup and autosave directories if they don't exist
(unless (file-exists-p "~/.emacs.d/autosave/")
  (make-directory "~/.emacs.d/autosave/"))
(unless (file-exists-p "~/.emacs.d/backups/")
  (make-directory "~/.emacs.d/backups/"))

;; Set backup files and autosave files to save in a sane location
(setq backup-by-copying t
      backup-directory-alist '((".*" . "~/.emacs.d/backups/"))
      auto-save-file-name-transforms '((".*" "~/.emacs.d/autosave/" t))
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

;; Disable lockfiles
(setq create-lockfiles nil)

;; Always follow symlinks
(setq vc-follow-symlinks t)

;; Use ssh for tramp
(setq tramp-default-method "ssh")

;; C->/< for indenting and de-indenting selection
(global-set-key (kbd "C->") 'indent-rigidly-right-to-tab-stop)
(global-set-key (kbd "C-<") 'indent-rigidly-left-to-tab-stop)

;; pdf-view
(use-package pdf-tools
  :mode ("\\.pdf\\'" . pdf-tools-install)
  :config
  (setq mouse-wheel-follow-mouse t)
  ;; Taken from the pdf-view issues page
  (defun my-pdf-generate-bookmark-name ()
    (concat "PDF-LAST-VIEWED: " (buffer-file-name)))
  (defun my-pdf-set-last-viewed-bookmark ()
    (interactive)
    (when (eq major-mode 'pdf-view-mode)
      (bookmark-set (my-pdf-generate-bookmark-name))))
  (defun my-pdf-jump-last-viewed-bookmark ()
    (when (my-pdf-has-last-viewed-bookmark)
      (bookmark-jump (my-pdf-generate-bookmark-name))))
  (defun my-pdf-has-last-viewed-bookmark ()
    (member (my-pdf-generate-bookmark-name) (bookmark-all-names)))
  (defun my-pdf-set-all-last-viewed-bookmarks ()
    (dolist (buf (buffer-list))
      (with-current-buffer buf
	(my-pdf-set-last-viewed-bookmark))))
  (add-hook 'kill-buffer-hook 'my-pdf-set-last-viewed-bookmark)
  (add-hook 'pdf-view-mode-hook 'my-pdf-jump-last-viewed-bookmark)
  (unless noninteractive
    (add-hook 'kill-emacs-hook 'my-pdf-set-all-last-viewed-bookmarks)))

;; exec-path-from-shell
(use-package exec-path-from-shell
  :config
  (exec-path-from-shell-initialize))

;; undo-tree
(use-package undo-tree
  :init (global-undo-tree-mode))

;; yaml-mode
(use-package yaml-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
  (add-hook 'yaml-mode-hook
	    '(lambda () (define-key yaml-mode-map "\C-m" 'newline-and-indent))))

;;(use-package aggressive-indent
;;  :hook ('prog-mode . #'aggressive-indent-mode))

(provide 'init-general)
