{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.servers.redpanda;
in {
  options = {
    modules.servers.redpanda = {
      enable =
        mkEnableOption "servers.redpanda"
        // {
          default = false;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      homebrew.taps = [
        "redpanda-data/tap"
      ];
      homebrew.brews = [
        "redpanda-data/tap/redpanda"
      ];
    }
    {
      my.hm.user.programs.zsh.oh-my-zsh.plugins = [
      ];
    }
  ]);
}
