# # BROKEN
{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.applications.networking.cluster.gcloud;
in {
  options = {
    modules.applications.networking.cluster.gcloud = {
      enable = mkEnableOption "applications.networking.cluster.gcloud" // {default = true;};
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.user = {
        home = {
          sessionPath = ["$HOME/.config/krew/bin"];
          sessionVariables = {
            CLOUDSDK_HOME = "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/";
          };
        };
      };
    }
    {
      homebrew.casks = [
        "google-cloud-sdk"
      ];
    }
    {
      my.hm.user.programs.zsh.oh-my-zsh.plugins = [
        "gcloud"
      ];
    }
  ]);
}
