{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.k8s;
in {
  options = {
    modules.tools.k8s = {
      enable =
        mkEnableOption "tools.k8s"
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
            KUBECONFIG = "$HOME/.config/k8s/config.yaml";
          };
        };
      };
      my.user.packages = with pkgs; [
        argocd
        krew
        # kubectl
        kubernetes-helm
        kustomize
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
