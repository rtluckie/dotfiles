{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.helix;
in {
  options = {
    modules.tools.helix = {
      enable =
        mkEnableOption "tools.helix"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.user.programs.helix = {
        enable = true;
        languages = [
          {
            name = "rust";
            auto-format = false;
          }
        ];

        settings = {
          theme = "dracula_at_night";
          editor = {
            mouse = true;
            file-picker = {
              hidden = false;
            };
            cursor-shape = {
              insert = "bar";
              normal = "block";
              select = "underline";
            };
          };
          keys.normal = {
            space.space = "file_picker";
            space.w = ":w";
            space.q = ":q";
          };
        };
      };
    }
  ]);
}
