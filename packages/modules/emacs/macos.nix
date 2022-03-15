{ ... }: {
  imports = [
    ./common.nix
    doom/macos.nix
  ];
  programs.emacs.enable = true;
}
