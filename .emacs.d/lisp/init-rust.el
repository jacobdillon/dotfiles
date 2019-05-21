;;; Config for Rust and related modes/tools

(use-package rust-mode)

(use-package cargo
  :after rust-mode
  :config (setq cargo-process--command-fmt "cargo +nightly fmt")
  (add-hook 'rust-mode-hook 'cargo-minor-mode))

(provide 'init-rust)
