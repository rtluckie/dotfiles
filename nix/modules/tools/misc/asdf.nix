{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.misc.asdf;
in {
  options = {
    modules.tools.misc.asdf = {
      enable =
        mkEnableOption "tools.misc.asdf"
        // {
          default = true;
        };
    };
  };
  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.user.home.packages = with pkgs; [
        asdf-vm
      ];
    }
    {
      my.hm.user.programs.zsh.oh-my-zsh.plugins = [
        "asdf"
      ];
    }
  ]);
}
