{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.applications.networking.cluster.k8s;
in {
  options = {
    modules.applications.networking.cluster.k8s = {
      enable =
        mkEnableOption "applications.networking.cluster.k8s"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.user = {
        home = {
          sessionPath = ["$HOME/.config/krew/bin"];
          sessionVariables = {
            KREW_ROOT = "$HOME/.config/krew";
            KUBECONFIG = "$HOME/.config/k8s/configs/main.yaml";
          };
        };
      };
      my.hm.user.home.packages = with pkgs; [
        argocd
        krew
        kubectl
        kubectx
        kubernetes-helm
        kustomize
        stern
        tanka
      ];
    }
    {
      my.hm.user.programs.zsh.oh-my-zsh.plugins = [
        "kubectl"
        "helm"
      ];
    }
  ]);
}
