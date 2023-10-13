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
      my.hm.user.programs.zsh.oh-my-zsh.plugins = [
      ];
    }
    {
      my.hm.user.home.packages = with pkgs; [
        nodejs_20

        nodePackages.yarn
        nodePackages.pkg
        nodePackages.typescript
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
      my.hm.user.home = {
        sessionVariables = {
        };
        sessionPath = [
          "$HOME/.cache/npm/bin"
        ];
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
