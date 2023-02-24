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
          "$HOME/.local/share/google-cloud-sdk/bin"
        ];
      };
    }
    {
      my.hm.user = {
        home = {
          sessionPath = ["$HOME/.config/krew/bin"];
          sessionVariables = {
            CLOUDSDK_HOME = "$HOME/.local/share/google-cloud-sdk";
          };
        };
      };
    }
    {
      my.hm.user.programs.zsh.oh-my-zsh.plugins = [
        "gcloud"
      ];
    }
  ]);
}
