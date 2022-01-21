{ pkgs, config, lib, options, ... }:
let
  fish_config = builtins.readFile ./config/config.fish;

in {
  programs.fish = {
    shellInit = fish_config;
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
      darwin-reload = ''
        darwin-rebuild switch -I darwin-config=$_DARWIN_CONFIG
      '';

      load_nix = ''
        # Don't execute this file when running in a pure nix-shell.
        if test "$IN_NIX_SHELL"
           or test ! -e "$_DARWIN_CONFIG"
           return
        end

        if test ! -e "$__NIX_DARWIN_SET_ENVIRONMENT_DONE"
          fenv source /nix/store/6nzvy4gzmqblacm0h6yci4nk9b139gkr-set-environment > /dev/null
        end
      '';

      cachix_push = ''
        nix flake archive --json \
        | jq -r '.path,(.inputs|to_entries[].value.path)' \
        | cachix push smpoulsen-cache
        end
      '';

      docker_rm_by_name = ''
                    --argument name
                     docker ps -a --format "{{.ID}} {{.Image}} {{.Names}}" | grep "$name" | awk '{print $1}' | xargs -I {} docker rm {}
      end
      '';

      ssh_reset_yubikey = ''
        gpg-connect-agent "scd serialno" "learn --force" /bye
        end
        '';

      yubikey_5ci = ''
        ykman --device 14411590 $argv
        end
      '';

        yubikey_5nfc = ''
          ykman --device 16752700 $argv
          end
        '';
    };
  };

}
