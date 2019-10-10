;;; Config for Rust and related modes/tools

(use-package lsp-mode)

(use-package rustic
  :after lsp-mode)

(use-package cargo
  :after rustic
  :config (setq cargo-process--command-fmt "cargo +nightly fmt")
  (add-hook 'rust-mode-hook 'cargo-minor-mode))

(provide 'init-rust)
