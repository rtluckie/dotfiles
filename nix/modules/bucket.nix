{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.bucket;
in {
  options = {
    modules.bucket = {
      enable =
        mkEnableOption "bucket"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      environment.systemPackages = with pkgs; [
        buildpack
        jdk17
        bazel
      ];
    }
    {
      homebrew.brews = [
        # "carvel-dev/carvel"
        # "buildpacks/tap/pack"
        "buildpacks/tap/pack"
        "ytt"
        "kbld"
        "kapp"
        "kwt"
        "imgpkg"
        "vendir"
        "kctrl"
      ];
    }
    {
      my.hm.user.home.packages = with pkgs; [
        tailscale
      ];
    }
    {
      my.hm.user.programs.zsh.oh-my-zsh.plugins = [
      ];
    }
  ]);
}
