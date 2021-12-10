{ options, ... }: let

  init = (import ./init.el.nix { inherit options; });
  config = (import ./config.el.nix { inherit options; });
  packages = (import ./packages.el.nix { inherit options; });

in {
  init = init.cfg;
  config = config.cfg;
  packages = packages.cfg;
}
