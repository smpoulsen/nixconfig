{ pkgs, config, lib, options, ... }:
  let
    doomConfig = (import ./doom-config { inherit options; });
    privateConfig = (import ./private { inherit options; });

    doomRepo = builtins.fetchGit {
      url = "https://github.com/hlissner/doom-emacs";
      ref = "develop";
      rev = "f458f9776049fd7e9523318582feed682e7d575c";
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

  in {

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
        "doom-config/config.el".text = "${doomConfig.config}";
        "doom-config/init.el".text = "${doomConfig.init}";
        "doom-config/packages.el".text = "${doomConfig.packages}";
        "doom-config/private/init.el".text = "${privateConfig.private.init}";
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

        ## Doom dependencies
        git
        (ripgrep.override {withPCRE2 = true;})
        gnutls              # for TLS connectivity

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
        # :lang cc
        # ccls
        # :lang javascript
        nodePackages.typescript-language-server
        # :lang latex & :lang org (latex previews)
        texlive.combined.scheme-medium
        # :lang beancount
        # beancount
        # unstable.fava  # HACK Momentarily broken on nixos-unstable
        # :lang rust
        rustfmt
        # unstable.rust-analyzer
        ];
}
