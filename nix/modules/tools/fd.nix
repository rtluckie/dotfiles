{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.fd;
in {
  options = {
    modules.tools.fd = {
      enable =
        mkEnableOption "tools.fd"
        // {
          default = true;
        };
    };
  };
  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.user.home.packages = with pkgs; [
        fd
      ];
    }
    {
      my.hm.user.programs.zsh.oh-my-zsh.plugins = [
        "fd"
      ];
    }
  ]);
}
