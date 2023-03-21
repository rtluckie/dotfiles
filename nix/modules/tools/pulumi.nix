{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.pulumi;
in {
  options = {
    modules.tools.pulumi = {
      enable =
        mkEnableOption "tools.pulumi"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.user = {
        home = {
          sessionPath = [
            # "$HOME/.config/krew/bin"
          ];
          sessionVariables = {
            # KUBECONFIG = "$HOME/.config/pulumi/config.yaml";
          };
        };
      };
      my.hm.user.home.packages = with pkgs; [
        tf2pulumi
      ];
    }
    {
      homebrew.brews = [
        {
          name = "pulumi";
          args = [
            "ignore-dependencies"
          ];
        }
      ];
    }
    {
      my.hm.user.programs.zsh.oh-my-zsh.plugins = [
      ];
    }
    {
      my.hm.user.programs.zsh.initExtra = ''
        eval "$(pulumi gen-completion zsh)"
      '';
    }
  ]);
}
