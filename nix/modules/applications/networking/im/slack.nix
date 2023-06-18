{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.applications.networking.im.slack;
in {
  options = {
    modules.applications.networking.im.slack = {
      enable =
        mkEnableOption "applications.networking.im.slack"
        // {
          default = true;
        };
    };
  };
  config = mkIf cfg.enable (mkMerge [
    # {
    #   homebrew.casks = [
    #     "slack"
    #   ];
    # }
    {
      my.hm.user.home.packages = with pkgs; [
        slack
      ];
    }
  ]);
}
