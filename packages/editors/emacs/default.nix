{ pkgs, config, lib, options, ... }:
with lib;

let
  cfg = config.sylvie.packages.editors.emacs;
  isMac = pkgs.system == "x86_64-darwin";

  doomConfig = (import doom/doom-config { inherit options; });
  privateConfig = (import doom/private { inherit options; });

  doomRepo = builtins.fetchGit {
    url = "https://github.com/hlissner/doom-emacs";
    ref = "master";
    rev = "42e5763782fdc1aabb9f2624d468248d6978abe2";
  };

  doomChangeScript = ''
      export DOOMDIR="${config.home.sessionVariables.DOOMDIR}"
      export DOOMLOCALDIR="${config.home.sessionVariables.DOOMLOCALDIR}"
      if [ ! -d "$DOOMLOCALDIR" ]; then
      ${config.xdg.configHome}/emacs/bin/doom -y install
      else
      ${config.xdg.configHome}/emacs/bin/doom -y sync -u
      fi
    '';

  doomSyncScript = ''
      export DOOMDIR="${config.home.sessionVariables.DOOMDIR}"
      export DOOMLOCALDIR="${config.home.sessionVariables.DOOMLOCALDIR}"
      ${config.xdg.configHome}/emacs/bin/doom -y sync
    '';

in {
  options.sylvie.packages.editors.emacs = {
    enable = mkEnableOption "emacs config";
  };

  config = mkIf cfg.enable {
    programs.emacs.enable = true;

    home = {
      sessionPath = [ "${config.xdg.configHome}/emacs/bin" ];
      sessionVariables = {
        DOOMDIR = "${config.xdg.configHome}/doom-config";
        DOOMLOCALDIR = "${config.xdg.configHome}/doom-local";
      };
    };

    xdg = {
      enable = true;
      configFile = {
        "doom-config/config.el"= {
          text = "${doomConfig.config}";
          onChange = "${pkgs.writeShellScript "doom-change" doomSyncScript}";
        };
        "doom-config/init.el"= {
          text = "${doomConfig.init}";
          onChange = "${pkgs.writeShellScript "doom-change" doomSyncScript}";
        };
        "doom-config/packages.el"= {
          text = "${doomConfig.packages}";
          onChange = "${pkgs.writeShellScript "doom-change" doomSyncScript}";
        };
        "doom-config/private/init.el"= {
          text = "${privateConfig.private.init}";
          onChange = "${pkgs.writeShellScript "doom-change" doomSyncScript}";
        };
        "emacs" = {
          source = doomRepo;
          onChange = "${pkgs.writeShellScript "doom-change" doomChangeScript}";
        };
      };
    };

    home.packages = with pkgs; [
      # DOOM Emacs dependencies
      emacs-all-the-icons-fonts
      ## Emacs itself
      binutils       # native-comp needs 'as', provided by this
      # emacsPgtkGcc   # 28 + pgtk + native-comp
      # ((emacsPackagesNgGen emacsPgtkGcc).emacsWithPackages (epkgs: [
      #  epkgs.vterm
      # ]))

      ## Doom dependencies
      git
      (ripgrep.override {withPCRE2 = true;})
      gnutls              # for TLS connectivity

      emacsPackages.ggtags
      emacsPackages.golden-ratio
      # emacsPackages.multi-vterm
      # emacsPackages.vterm

      ## Optional dependencies
      fd                  # faster projectile indexing
      imagemagick         # for image-dired
      pinentry_emacs      # in-emacs gnupg prompts
      zstd                # for undo-fu-session/undo-tree compression

      ## Module dependencies
      # :checkers spell
      (aspellWithDicts (ds: with ds; [
        en en-computers en-science
      ]))
      # :checkers grammar
      languagetool
      # :tools editorconfig
      editorconfig-core-c # per-project style config
      # :tools lookup & :lang org +roam
      sqlite
      # :lang javascript
      nodePackages.typescript-language-server
      # :lang latex & :lang org (latex previews)
      texlive.combined.scheme-medium
      # unstable.fava  # HACK Momentarily broken on nixos-unstable
      # :lang rust
      rustfmt
      # unstable.rust-analyzer
    ] ++ (if isMac
         then []
         else [
           # :lang cc
           ccls
           # :lang beancount
           beancount
         ]);
  };
}
