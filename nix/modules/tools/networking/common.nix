{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.networking.common;
in {
  options = {
    modules.tools.networking.common = {
      enable =
        mkEnableOption "tools.networking.common"
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
        dig
        iftop
        inetutils
        ipcalc
        nmap
        speedtest-cli
        wget
      ];
    }
    {
      my.hm.user.programs.zsh.oh-my-zsh.plugins = [
        "nmap"
      ];
    }
  ]);
}
