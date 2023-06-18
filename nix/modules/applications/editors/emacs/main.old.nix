{
  pkgs,
  lib,
  config,
  options,
  inputs,
  ...
}: let
  emacsPkg = pkgs.emacsWithPackagesFromUsePackage {
    alwaysEnsure = true;
    alwaysTangle = true;
    config = "$HOME/.config/doom/config.org";
    package = pkgs.emacs;
    extraEmacsPackages = epkgs: [
      epkgs.vterm
    ];
  };
  cfg = config.modules.applications.editors.emacs;
in {
  options = with lib; {
    modules.applications.editors.emacs = {
      enable =
        mkEnableOption "applications.editors.emacs"
        // {
          default = false;
        };
    };
  };

  config = with lib;
    mkIf cfg.enable (mkMerge [
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
            sessionPath = ["$HOME/.config/emacs/bin"];
            sessionVariables = {
              # EMACS = "${emacsPkg}/bin/emacs";
              EMACSDIR = "$HOME/.config/emacs";
            };
            packages = with pkgs; [
              (aspellWithDicts (ds: [ds.en ds.en-computers ds.en-science]))

              # gmp
              # gnutls
              # libgccjit
              # libjpeg
              # librsvg
              editorconfig-core-c
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
              taplo-lsp
              texlive.combined.scheme-medium
              wordnet
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
        my.hm.user.programs.zsh.oh-my-zsh.plugins = [
          "emacs"
        ];
      }
    ]);
}
