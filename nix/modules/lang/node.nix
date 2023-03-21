{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.lang.node;
in {
  options = {
    modules.lang.node = {
      enable =
        mkEnableOption "lang.node"
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
  ]);
}
