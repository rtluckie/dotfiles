{
  pkgs,
  lib,
  config,
  options,
  inputs,
  ...
}: {
  config = with lib;
    mkMerge [
      {
        fonts.fontDir.enable = true;
        fonts.fonts = with pkgs; [
          font-awesome
          (
            nerdfonts.override {
              fonts = [
                "FiraCode"
                "FiraMono"
                # "Noto"
                "VictorMono"
              ];
            }
          )
        ];
      }
      {
        my.fonts = rec {
          default = {
            name = "VictorMono Nerd Font";
            size = 22;
          };
          big = {
            name = config.my.fonts.default.name;
            size = builtins.floor (config.my.fonts.default.size + (config.my.fonts.default.size * 0.15));
          };
          mono = {
            name = config.my.fonts.default.name;
            size = config.my.fonts.default.size;
          };
          serif = {
            name = "NotoSerif Nerd Font";
            size = config.my.fonts.default.size;
          };
          unicode = {
            name = config.my.fonts.default.name;
            size = config.my.fonts.default.size;
          };
          variablePitch = {
            name = config.my.fonts.default.name;
            size = config.my.fonts.default.size;
          };
        };
      }
    ];
}
