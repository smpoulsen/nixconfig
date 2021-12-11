{ options, ... }: let

  projectRoot = "~/code";

  initFile = ''
    (provide 'init)

    ;; projectile config
    (projectile-add-known-project "~/nixconfig")
    (projectile-add-known-project "${projectRoot}/dotfiles")
  '';
in {
  cfg = initFile;
}
