{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.redpanda;
in {
  options = {
    modules.tools.redpanda = {
      enable =
        mkEnableOption "tools.redpanda"
        // {
          default = true;
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
