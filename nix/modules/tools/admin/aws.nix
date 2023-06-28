{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.admin.aws;
in {
  options = {
    modules.tools.admin.aws = {
      enable =
        mkEnableOption "tools.admin.aws"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.user.home.packages = with pkgs; [
        awscli2
      ];
    }
    {
      my.hm.user = {
        home = {
          sessionVariables = {
            AWS_CONFIG_FILE = "${config.my.hm.confiDir}/aws/config";
            AWS_SHARED_CREDENTIALS_FILE = "${config.my.hm.configDir}/aws/credentials";
          };
        };
      };
    }
    {
      my.hm.user.programs.zsh.oh-my-zsh.plugins = [
        aws
      ];
    }
  ]);
}
