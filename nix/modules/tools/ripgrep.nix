{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.ripgrep;
in {
  options = {
    modules.tools.ripgrep = {
      enable =
        mkEnableOption "tools.ripgrep"
        // {
          default = true;
        };
    };
  };
  config = mkIf cfg.enable (mkMerge [
    {
      my.user.packages = with pkgs; [
        (pkgs.ripgrep.override {withPCRE2 = true;})
      ];
    }
    {
      my.hm.user.programs.zsh.oh-my-zsh.plugins = [
        "ripgrep"
      ];
    }
  ]);
}
