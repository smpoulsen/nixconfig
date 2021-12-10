{ options, ... }: let

  init = (import ./init.el.nix { inherit options; });

in {
  private = {
    init = init.cfg;
  };
}
