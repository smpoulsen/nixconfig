{ pkgs, ... }: {
  # # Add emacs overlay to get emacs 28.
  # nixpkgs.overlays = [
  #   (import (builtins.fetchTarball {
  #     url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
  #   }))
  # ];

  # programs.emacs = {
  #   enable = true;
  #   package = nixpkgs.emacsUnstable;
  # };
}
