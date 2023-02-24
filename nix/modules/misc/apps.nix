{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.misc.apps;
in {
  options = {
    modules.misc.apps = {
      enable =
        mkEnableOption "misc.apps"
        // {
          default = false;
        };
    };
  };
  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.user.home.activation = {
        copyApplications = let
          apps = pkgs.buildEnv {
            name = "home-manager-applications";
            paths = config.my.user.packages;
            pathsToLink = "/Applications";
          };
        in
          inputs.home-manager.lib.hm.dag.entryAfter ["linkGeneration"] ''
            baseDir="$HOME/Applications/Home Manager Apps"
            if [ -d "$baseDir" ]; then
              $DRY_RUN_CMD rm -rf "$baseDir"
            fi
            $DRY_RUN_CMD mkdir -p "$baseDir"
            for appFile in ${apps}/Applications/*; do
              target="$baseDir/$(basename "$appFile")"
              $DRY_RUN_CMD cp ''${VERBOSE_ARG:+-v} -fHRL "$appFile" "$baseDir"
              $DRY_RUN_CMD chmod ''${VERBOSE_ARG:+-v} -R +w "$target"
            done
          '';
      };
    }
  ]);
}
