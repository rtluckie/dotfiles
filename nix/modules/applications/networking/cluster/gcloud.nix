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

    # {
    #   my.hm.user.home.packages = with pkgs; [
    #     (
    #       google-cloud-sdk.withExtraComponents [
    #         google-cloud-sdk.components.anthos-auth
    #         google-cloud-sdk.components.anthoscli
    #         google-cloud-sdk.components.appctl
    #         google-cloud-sdk.components.beta
    #         google-cloud-sdk.components.cbt
    #         google-cloud-sdk.components.gcloud
    #         google-cloud-sdk.components.gke-gcloud-auth-plugin
    #         google-cloud-sdk.components.gsutil
    #         google-cloud-sdk.components.harbourbridge
    #         google-cloud-sdk.components.kpt
    #         google-cloud-sdk.components.kubectl
    #         google-cloud-sdk.components.kubectl-oidc
    #         google-cloud-sdk.components.kustomize
    #         google-cloud-sdk.components.local-extract
    #         google-cloud-sdk.components.nomos
    #         google-cloud-sdk.components.pkg
    #         google-cloud-sdk.components.skaffold
    #         google-cloud-sdk.components.ssh-tools
    #         google-cloud-sdk.components.terraform-tools
    #       ]
    #     )
    #   ];
    # }

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
