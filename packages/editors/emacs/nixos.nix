{ ... }: {
  imports = [
    ./common.nix
    doom/nixos.nix
  ];
  programs.emacs.enable = true;
}
