(defun my-insert-empty-line ()
  (interactive)
  (move-end-of-line nil)
  (open-line 1)
  (next-line 1))

(global-set-key [S-return] 'my-insert-empty-line)

(provide 'my-functions)
