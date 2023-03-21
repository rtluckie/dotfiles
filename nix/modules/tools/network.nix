{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.network;
in {
  options = {
    modules.tools.network = {
      enable =
        mkEnableOption "tools.network"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.user.home.packages = with pkgs; [
        bind
        curl
        iftop
        nmap
        speedtest-cli
        wget
        ipcalc
      ];
    }
    {
      my.hm.user.programs.zsh.oh-my-zsh.plugins = [
        "nmap"
      ];
    }
  ]);
}
