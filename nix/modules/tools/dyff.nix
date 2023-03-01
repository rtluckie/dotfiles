{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.dyff;
in {
  options = {
    modules.tools.dyff = {
      enable =
        mkEnableOption "tools.dyff"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      my.user.packages = with pkgs; [
        dyff
      ];
    }
    {
      my.hm.user.programs.git = {
        extraConfig = {
          diff.dyff.command = "dyff_between() { dyff --color on between --omit-header \"$2\" \"$5\"; }; dyff_between";
        };
      };
    }
    {
      my.hm.user.home.sessionVariables = {
        KUBECTL_EXTERNAL_DIFF = "dyff between --omit-header --set-exit-code";
      };
    }
  ]);
}
