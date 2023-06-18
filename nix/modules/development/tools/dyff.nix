{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.development.tools.dyff;
in {
  options = {
    modules.development.tools.dyff = {
      enable =
        mkEnableOption "development.tools.dyff"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.user.home.packages = with pkgs; [
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
