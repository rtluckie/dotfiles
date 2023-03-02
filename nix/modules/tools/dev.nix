{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.dev;
in {
  options = {
    modules.tools.dev = {
      enable =
        mkEnableOption "tools.dev"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      environment.systemPackages = with pkgs; [
      ];
    }
    {
      my.user.packages = with pkgs; [
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
  ]);
}
