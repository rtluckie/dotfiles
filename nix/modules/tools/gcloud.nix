# # BROKEN
{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.gcloud;
in {
  options = {
    modules.tools.gcloud = {
      enable = mkEnableOption "tools.gcloud" // {default = true;};
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      my.env = {
        PATH = [
          "$PATH"
          "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/bin"
        ];
      };
    }
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
