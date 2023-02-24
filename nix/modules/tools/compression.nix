{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.compression;
in {
  options = {
    modules.tools.compression = {
      enable =
        mkEnableOption "tools.compression"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      my.user.packages = with pkgs; [
        gnutar
        p7zip
        unrar
        unzip
        xz
        zip
        zstd
      ];
    }
    {
      my.hm.user.programs.zsh.oh-my-zsh.plugins = [
        "extract"
      ];
    }
  ]);
}
