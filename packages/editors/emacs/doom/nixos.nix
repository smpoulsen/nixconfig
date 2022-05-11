{ pkgs, ... }: {
  imports = [
    ./common.nix
  ];

  home.packages = with pkgs; [
    # :lang cc
    ccls
    # :lang beancount
    beancount
  ];
}
