{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.development.common;
in {
  options = {
    modules.development.common = {
      enable =
        mkEnableOption "development.common"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      environment.systemPackages = with pkgs; [
        autoconf
        cmake
        coreutils
        # coreutils-prefixed
        gawk
        gcc
        gnumake
        gnused
        gnutar
        gnutls
        libgccjit
        librsvg
        libtool
        mailutils
        moreutils
        pkg-config
        sqlite
        # texinfo
        xz
      ];
    }
    {
      my.hm.user.home.packages = with pkgs; [
        nodePackages.prettier
        nodePackages.prettier-plugin-toml
        sqlite
        autoconf
        # binutils
        cmake
        coreutils-prefixed
        gcc
        gnumake
        libgccjit
        moreutils
        texinfo
        pkg-config
      ];
    }
    {
      my.hm.user.programs.zsh.oh-my-zsh.plugins = [
        "gnu-utils"
      ];
    }
  ]);
}
