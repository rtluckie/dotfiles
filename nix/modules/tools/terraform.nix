{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.terraform;
in {
  options = {
    modules.tools.terraform = {
      enable =
        mkEnableOption "tools.terraform"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      my.user.packages = with pkgs; [
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
