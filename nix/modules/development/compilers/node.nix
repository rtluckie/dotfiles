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
  ]);
}
