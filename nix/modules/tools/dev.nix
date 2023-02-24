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
        cmake
        coreutils-prefixed
        gcc
        gnumake
        libgccjit
        moreutils
      ];
    }
    {
      my.user.packages = with pkgs; [
        nodePackages.prettier
        nodePackages.prettier-plugin-toml
      ];
    }
  ]);
}
