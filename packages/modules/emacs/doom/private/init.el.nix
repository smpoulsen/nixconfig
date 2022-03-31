{ options, ... }: let

  projectRoot = "~/code";

  initFile = ''
    (provide 'init)

    ;; projectile config
    (projectile-add-known-project "~/nixconfig")
    (projectile-add-known-project "${projectRoot}/dotfiles")

    (use-package! undo-tree
                  :config
                   (global-undo-tree-mode))

    (add-hook 'sql-mode-hook 'sqlup-mode)
    (add-hook 'sql-interactive-mode-hook 'sqlup-mode)

    (add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
  '';
in {
  cfg = initFile;
}
