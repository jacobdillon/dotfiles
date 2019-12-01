
(use-package slime
  :config
  (setq inferior-lisp-program (executable-find "sbcl"))
  (setq slime-contribs '(slime-fancy)))

(provide 'init-lisp)
