{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.podman;
in {
  options = {
    modules.tools.podman = {
      enable =
        mkEnableOption "tools.podman"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      homebrew.casks = [
        "podman-desktop"
      ];
    }
    {
      my.hm.user.home.packages = with pkgs; [
        podman
        podman-compose
      ];
    }
  ]);
}
