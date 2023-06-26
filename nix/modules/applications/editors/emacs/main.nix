{
  pkgs,
  lib,
  config,
  options,
  inputs,
  ...
}: let
  emacsVersion = "28";
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
          autoconf
          brotli
          cairo
          cmake
          coreutils
          # coreutils-prefixed
          dbus
          fontconfig
          freetype
          fribidi
          gawk
          gcc
          gdk-pixbuf
          ghostscript
          giflib
          glib
          gmp
          gnumake
          gnused
          gnutar
          gnutls
          graphite2
          harfbuzz
          icu
          # imagemagick
          # imagemagickBig
          imath
          isl
          jansson
          jasper
          jbig2dec
          lcms2
          libavif
          libde265
          libgccjit
          libheif
          libhwy
          libidn
          libjpeg
          libjxl
          liblqr1
          libmpc
          libraw
          librsvg
          libtiff
          libtool
          libvmaf
          libwebp
          llvmPackages.openmp
          mailutils
          moreutils
          mpfr
          openexr
          openjpeg
          pango
          pkg-config
          shared-mime-info
          sqlite
          # texinfo
          tree-sitter
          tree-sitter-grammars.tree-sitter-yaml
          x265
          # xorg.libX11
          # xorg.libXau
          # xorg.libxcb
          # xorg.libXdmcp
          # xorg.libXext
          # xorg.libXrender
          # xorg.xorgproto
          xz
          zlib
        ];
      }
      {
        my.hm.user = {
          home = {
            sessionPath = ["$HOME/.config/emacs/bin"];
            sessionVariables = {
              # EMACS = "${emacsPkg}/bin/emacs";
              EMACSDIR = "$HOME/.config/emacs";
            };
            packages = with pkgs; [
              (aspellWithDicts (ds: [ds.en ds.en-computers ds.en-science]))

              editorconfig-core-c
              html-tidy
              # imagemagick
              languagetool
              nodePackages.bash-language-server
              nodePackages.eslint
              nodePackages.javascript-typescript-langserver
              nodePackages.js-beautify
              nodePackages.stylelint
              nodePackages.unified-language-server
              nodePackages.yaml-language-server
              shellcheck
              shfmt
              taplo-lsp
              texlive.combined.scheme-medium
              wordnet
            ];
          };
        };
      }
      {
        my.hm.user.programs.zsh.oh-my-zsh.plugins = [
          "emacs"
        ];
      }
      {
        homebrew.taps = [
          "d12frosted/emacs-plus"
        ];
        homebrew.brews = [
          "imagemagick"
          "libgccjit"
          "texinfo"
          "gcc"
          {
            name = "d12frosted/emacs-plus/emacs-plus@${emacsVersion}";
            args = [
              "ignore-dependencies"
              "with-no-titlebar-and-round-corners"
              "with-native-comp"
              "with-memeplex-slim-icon"
              "with-xwidgets"
              "with-imagemagick"
              "with-mailutils"
            ];
            restart_service = false;
            start_service = false;
          }
        ];
      }
      {
        my.hm.user.home.activation.emacs = with pkgs;
          inputs.home-manager.lib.hm.dag.entryAfter ["writeBoundary"] ''
            export EMACS_VERSION=${emacsVersion};
            export APP_SPATH="/opt/homebrew/opt/emacs-plus@$EMACS_VERSION/Emacs.app";
            export APP_DPATH='/Applications/Emacs.app'
            if [[ -d $APP_DPATH ]]; then
               rm -fr $APP_DPATH;
            fi
            if [[ -d $APP_SPATH ]]; then
              cp -r $APP_SPATH /Applications/
            fi
          '';
      }
    ]);
}
