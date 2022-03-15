{ pkgs, config, ...}:

let

  netrcChange = ''
  export GITHUB_USER="${config.home.sessionVariables.GITHUB_USER}"
  export GITHUB_PAT="${config.home.sessionVariables.GITHUB_PAT}"

  cat > /tmp/netrc <<- EOM
  machine github.com
  login $GITHUB_USER
  password $GITHUB_PAT
  protocol https
  EOM

  cd /tmp && gpg -e -r 1EC88F7533B94E7C /tmp/netrc
  mv /tmp/netrc.gpg ~/.config/.netrc.gpg
  rm /tmp/netrc
  '';

in {

  home = {
    sessionVariables = {
      GITHUB_USER = "smpoulsen";
      GITHUB_PAT = builtins.getEnv "GITHUB_PAT";
    };
  };

  home.file = {
    "netrc.gpg" = {
      text = "1";
      onChange = "${pkgs.writeShellScript "netrc-change" netrcChange}";
    };
  };

  programs.git = {
    enable = true;
    userName = "Sylvie Poulsen";
    userEmail = "git@poulsen.xyz";
    signing = {
      key = "AEB12283C38DBBE5";
    };
    extraConfig = {
      init = {
        defaultBranch = "main";
      };

      commit = {
        #gpgsign = true;
      };

      credential = {
	      helper = "netrc -f ~/.config/.netrc.gpg -v";
      };
    };
  };
}
