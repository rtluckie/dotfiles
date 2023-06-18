{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.misc.fd;
in {
  options = {
    modules.tools.misc.fd = {
      enable =
        mkEnableOption "tools.misc.fd"
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
