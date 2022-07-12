{ pkgs, config, lib, options, ... }:
with lib;

let
  cfg = config.sylvie.packages.shells.fish;

  fish_config = builtins.readFile ./config/config.fish;
  linux_nix_path = if pkgs.system == "x86_64-linux"
    then ''set -g NIX_PATH /home/spoulsen/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels:/home/spoulsen/.nix-defexpr/channels\n''
    else '''';

  gpg_auth_config = ''
                    set -x GPG_TTY (tty)
                    set -xg SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
                    gpgconf --launch gpg-agent
                    '';


  # see https://github.com/LnL7/nix-darwin/issues/122
  environment.etc."fish/nixos-env-preinit.fish".text = lib.mkMerge [
    (lib.mkBefore ''
      set -g __nixos_path_original $PATH
    '')
    (lib.mkAfter ''
      function __nixos_path_fix -d "fix PATH value"
      set -l result (string replace '$HOME' "$HOME" $__nixos_path_original)
      for elt in $PATH
        if not contains -- $elt $result
          set -a result $elt
        end
      end

      set -g PATH $result
      fenv source /run/current-system/etc/zshenv > /dev/null
      fish_config
      end

      ${fish_config}
      '')
  ];


in {
  options.sylvie.packages.shells.fish = {
    enable = mkEnableOption "fish config";

    set-gpg-auth = mkOption {
      type = types.bool;
      default = false;
      description = "Enable gpg for ssh auth";
    };
  };

  config = mkIf cfg.enable {

    # xdg = {
    #   enable = true;
    #   config = {
    #     "fish/config.fish" = {
    #       text = "${metadata}";
    #     };
    #     "paperwm/user.js" = {
    #       text = "${user_conf}";
    #     };
    #   };
    # };
    programs.fish = {
      enable = true;
      shellInit = fish_config + linux_nix_path + (
        if cfg.set-gpg-auth
        then fish_config + gpg_auth_config
        else fish_config
      );

      plugins = [
        {
          name = "pure";
          src = pkgs.fetchFromGitHub {
            owner = "pure-fish";
            repo = "pure";
            rev = "v3.5.0";
            sha256 = "Gh/untxgUsVGJzMbSWZXv5b4EoAEfhJ3pSNtNMI/KVs=";
          };
        }
        {
          name = "nix-env.fish";
          src = pkgs.fetchFromGitHub {
            owner = "lilyball";
            repo = "nix-env.fish";
            rev = "7b65bd228429e852c8fdfa07601159130a818cfa";
            sha256 = "RG/0rfhgq6aEKNZ0XwIqOaZ6K5S4+/Y5EEMnIdtfPhk=";
          };
        }
        {
          name = "fenv";
          src = pkgs.fetchFromGitHub {
            owner = "oh-my-fish";
            repo = "plugin-foreign-env";
            rev = "dddd9213272a0ab848d474d0cbde12ad034e65bc";
            sha256 = "er1KI2xSUtTlQd9jZl1AjqeArrfBxrgBLcw5OqinuAM=";
          };
        }
      ];

      functions = {
        # darwin-reload = ''
        #   darwin-rebuild switch -I darwin-config=$_DARWIN_CONFIG
        # '';

        load_nix = ''
        # Don't execute this file when running in a pure nix-shell.
        if test "$IN_NIX_SHELL"
           or test ! -e "$_DARWIN_CONFIG"
           return
        end

        fenv source /run/current-system/etc/zshenv > /dev/null
      '';

        cachix_push = ''
        nix flake archive --json \
        | jq -r '.path,(.inputs|to_entries[].value.path)' \
        | cachix push smpoulsen-cache
      '';

        docker_rm_by_name = ''
      --argument name
        docker ps -a --format "{{.ID}} {{.Image}} {{.Names}}" | grep "$name" | awk '{print $1}' | xargs -I {} docker rm {}
      '';

        ssh_reset_yubikey = ''
        gpg-connect-agent "scd serialno" "learn --force" /bye
        '';

        yubikey_5ci = ''
        ykman --device 14411590 $argv
      '';

        yubikey_5nfc = ''
        ykman --device 16752700 $argv
      '';
      };
    };
  };
}
