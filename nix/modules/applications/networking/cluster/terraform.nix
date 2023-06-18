{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.applications.networking.cluster.terraform;
in {
  options = {
    modules.applications.networking.cluster.terraform = {
      enable =
        mkEnableOption "applications.networking.cluster.terraform"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.user.home.packages = with pkgs; [
        terraform
        terragrunt
      ];
    }
    {
      my.hm.user.programs.zsh.oh-my-zsh.plugins = [
        "terraform"
      ];
    }
  ]);
}
