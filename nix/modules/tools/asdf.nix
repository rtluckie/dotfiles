{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.asdf;
in {
  options = {
    modules.tools.asdf = {
      enable =
        mkEnableOption "tools.asdf"
        // {
          default = true;
        };
    };
  };
  config = mkIf cfg.enable (mkMerge [
    {
      my.user.packages = with pkgs; [
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
