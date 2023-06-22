{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.shells.bash;
in {
  options = {
    modules.shells.bash = {
      enable =
        mkEnableOption "shells.bash"
        // {
          default = true;
        };
    };
  };
  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.user = {
        home = {
          sessionVariables = {
            # EDITOR = "emacsclient --alternate-editor=\"\" --create-frame";
            # VISUAL = "$EDITOR";
            # PAGER = "less";
          };
        };
      };
    }
    {
      environment.shells = [pkgs.bashInteractive pkgs.bash];
      environment.systemPackages = [pkgs.bash];
      programs.bash.enable = true;
    }
    {
      my.user.shell = pkgs.bash;
    }
    {
      my.hm.user.programs.bash = rec {
        enable = true;
        enableCompletion = true;
      };
    }
  ]);
}
