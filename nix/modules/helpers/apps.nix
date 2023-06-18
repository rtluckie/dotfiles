{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.helpers.apps;
in {
  options = {
    modules.helpers.apps = {
      enable =
        mkEnableOption "helpers.apps"
        // {
          default = false;
        };
    };
  };
  config = mkIf cfg.enable (mkMerge [
    # {
    #   my.hm.user.home.activation = {
    #     copyApplications = let
    #       apps = pkgs.buildEnv {
    #         name = "home-manager-applications";
    #         paths = config.my.user.packages;
    #         pathsToLink = "/Applications";
    #       };
    #     in
    #       inputs.home-manager.lib.hm.dag.entryAfter ["linkGeneration"] ''
    #         baseDir="$HOME/Applications/Home Manager Apps"
    #         if [ -d "$baseDir" ]; then
    #           $DRY_RUN_CMD rm -rf "$baseDir"
    #         fi
    #         $DRY_RUN_CMD mkdir -p "$baseDir"
    #         for appFile in ${apps}/Applications/*; do
    #           target="$baseDir/$(basename "$appFile")"
    #           $DRY_RUN_CMD cp ''${VERBOSE_ARG:+-v} -fHRL "$appFile" "$baseDir"
    #           $DRY_RUN_CMD chmod ''${VERBOSE_ARG:+-v} -R +w "$target"
    #         done
    #       '';
    #   };
    # }
    {
      my.hm.user.home.activation = {
        # This should be removed once
        # https://github.com/nix-community/home-manager/issues/1341 is closed.
        aliasApplications = lib.hm.dag.entryAfter ["writeBoundary"] ''
          app_folder="$(echo ~/Applications)/Home Manager Apps"
          home_manager_app_folder="$genProfilePath/home-path/Applications"
          $DRY_RUN_CMD rm -rf "$app_folder"
          # NB: aliasing ".../home-path/Applications" to "~/Applications/Home Manager Apps" doesn't
          #     work (presumably because the individual apps are symlinked in that directory, not
          #     aliased). So this makes "Home Manager Apps" a normal directory and then aliases each
          #     application into there directly from its location in the nix store.
          $DRY_RUN_CMD mkdir "$app_folder"
          for app in $(find "$newGenPath/home-path/Applications" -type l -exec readlink -f {} \;)
          do
            $DRY_RUN_CMD osascript \
              -e "tell app \"Finder\"" \
              -e "make new alias file at POSIX file \"$app_folder\" to POSIX file \"$app\"" \
              -e "set name of result to \"$(basename $app)\"" \
              -e "end tell"
          done
        '';
      };
    }
  ]);
}
