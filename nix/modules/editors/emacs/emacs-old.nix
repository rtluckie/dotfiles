{
  pkgs,
  lib,
  config,
  options,
  inputs,
  ...
}: let
  cfg = config.modules.editors.emacs;
  emacsPkg = pkgs.emacsWithPackagesFromUsePackage {
    # alwaysEnsure = true;
    # alwaysTangle = true;
    config = "$HOME/.config/doom/config.org";
    package = pkgs.emacsPlusNativeComp;
    extraEmacsPackages = epkgs: [
      epkgs.vterm
    ];
  };
in {
  options = with lib; {
    modules.editors.emacs = {
      enable =
        mkEnableOption "editors.emacs"
        // {
          default = false;
        };
    };
  };

  config = with lib;
    mkIf cfg.enable (mkMerge [
      {
        my.env = {
          # EMACS = "${config.programs.emacs.package}/bin/emacs";
          EMACSDIR = "$HOME/.config/emacs";
          DOOMDIR = "$HOME/.config/doom";
          DOOMLOCALDIR = "$HOME/.config/doom-local";
          DOOMPROFILELOADFILE = "$HOME/.config/doom-local/profiles/load.el";
          PATH = ["$PATH" "$HOME/.config/emacs/bin"];
        };
      }
      {
        environment.systemPackages = with pkgs; [
          cmake
          coreutils-prefixed
          gcc
          gnumake
          libgccjit
          libtool
          moreutils
          shellcheck
          shfmt
        ];
        my.hm.user = {
          home = {
            # sessionPath = ["$HOME/.config/emacs/bin"];
            # sessionVariables = {
            #   # EMACS = "${emacsPkg}/bin/emacs";
            #   EMACSDIR = "$HOME/.config/emacs";
            #   DOOMDIR = "$HOME/.config/doom";
            #   DOOMLOCALDIR = "$HOME/.config/doom-local";
            #   DOOMPROFILELOADFILE = "$HOME/.config/doom-local/profiles/load.el";
            # };
            packages = with pkgs; [
              (aspellWithDicts (ds: [ds.en ds.en-computers ds.en-science]))
              # (ripgrep.override { withPCRE2 = true; })

              # autoconf
              # awk
              # binutils
              # emacsPkg
              # git
              # gmp
              # gnused
              # gnutar
              # gnutls
              # jansson
              # libgccjit
              # libjpeg
              # librsvg
              # pkg-config
              # texinfo
              # xz
              # zlib
              # coreutils
              editorconfig-core-c
              emacs-all-the-icons-fonts
              gnutls
              html-tidy
              imagemagick
              languagetool
              nodePackages.bash-language-server
              nodePackages.eslint
              nodePackages.javascript-typescript-langserver
              nodePackages.js-beautify
              nodePackages.stylelint
              nodePackages.unified-language-server
              nodePackages.yaml-language-server
              pandoc
              sqlite
              taplo-lsp
              texlive.combined.scheme-medium
              wordnet
              zstd
            ];
          };
        };
      }
      {
        services.emacs.enable = true;
      }
      {
        my.hm.user.programs.emacs.enable = true;
        my.hm.user.programs.emacs.package = emacsPkg;
      }
      {
        my.hm.configFile = {
          "doom" = {
            source = "${config.my.dotfiles.configDir}/doom";
            recursive = true;
          };
        };
      }
      {
        my.hm.user.home.activation.emacsDoom = inputs.home-manager.lib.hm.dag.entryAfter ["writeBoundary"] ''
          if [[ ! -d "$HOME/.config/emacs" ]]; then
          ${pkgs.git}/bin/git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
          fi
        '';
      }
    ]);
}
