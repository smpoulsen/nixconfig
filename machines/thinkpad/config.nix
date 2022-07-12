{
  allowUnfree = true;
  nix.extraOptions = ''
    experimental-features = nix-command
    experimental-features = flakes
  '';
}
