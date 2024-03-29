{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.applications.virtualization.podman;
in {
  options = {
    modules.applications.virtualization.podman = {
      enable =
        mkEnableOption "applications.virtualization.podman"
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
