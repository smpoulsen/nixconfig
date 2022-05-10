{ lib, pkgs, config, ... }:
with lib;

let
  cfg = config.sylvie.packages.git;
  gpgHelper = cfg.helper == "gpg";

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
  options.sylvie.packages.git = {
    enable = mkEnableOption "Git config";

    email = mkOption {
      type = types.str;
      default = "git@poulsen.xyz";
    };

    gpg = {
      sign = mkOption {
        type = types.bool;
        default = true;
      };
    };

    helper = {
      type = types.enum [ "netrc" "gpg" ];
      default = "netrc";
    };
  };

  config = mkIf cfg.enable {
    home = {
      sessionVariables = {
        GITHUB_USER = "smpoulsen";
        GITHUB_PAT = builtins.getEnv "GITHUB_PAT";
      };
    };

    home.file = mkIf gpgHelper {
      "netrc.gpg" = {
        text = "1";
        onChange = "${pkgs.writeShellScript "netrc-change" netrcChange}";
      };
    };

    programs.git = {
      enable = true;
      userName = "Sylvie Poulsen";
      userEmail = cfg.email;
      signing = {
        key = "AEB12283C38DBBE5";
      };
      extraConfig = {
        init = {
          defaultBranch = "main";
        };

        commit = {
          gpgsign = cfg.gpg.sign;
        };

        credential = {
          helper = if gpgHelper
                   then "netrc -f ~/.config/.netrc.gpg -v"
                   else "netrc -f ~/.config/.netrc -v" ;
        };
      };
    };
  };
}
