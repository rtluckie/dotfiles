{
  pkgs,
  lib,
  config,
  options,
  inputs,
  ...
}: let
  cfg = config.modules.editors.emacs;
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
          # {
          #   name = "d12frosted/emacs-plus/emacs-plus@29";
          #   args = [
          #     "ignore-dependencies"
          #     "with-native-comp"
          #     "with-memeplex-slim-icon"
          #     "with-xwidgets"
          #     "with-imagemagick"
          #     "with-mailutils"
          #   ];
          # }
          {
            name = "d12frosted/emacs-plus/emacs-plus@30";
            args = [
              "ignore-dependencies"
              "with-native-comp"
              "with-memeplex-slim-icon"
              "with-xwidgets"
              "with-imagemagick"
              "with-mailutils"
            ];
          }
        ];
      }
    ]);
}
