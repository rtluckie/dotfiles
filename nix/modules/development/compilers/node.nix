{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.development.compilers.node;
in {
  options = {
    modules.development.compilers.node = {
      enable =
        mkEnableOption "development.compilers.node"
        // {
          default = true;
        };
    };
  };
  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.user.home.packages = with pkgs; [
        nodejs
        nodePackages.yarn
      ];
    }
    {
      my.hm.user.programs.zsh.oh-my-zsh.plugins = [
        "yarn"
        "node"
        "npm"
      ];
    }

    {
      environment = {
        variables = {
        };
      };
    }
    {
      my.hm.user.home = {
        sessionVariables = {
          NPM_CONFIG_USERCONFIG = "$HOME/.config/npm/user.config";
          NPM_CONFIG_GLOBALCONFIG = "$HOME/.config/npm/global.config";
        };
      };
    }
    {
      my.hm.configFile."npm/user.config".text = ''
        prefix=${config.my.hm.cacheHome}/npm
      '';
    }
    {
      my.hm.configFile."npm/global.config".text = ''
      '';
    }
  ]);
}
