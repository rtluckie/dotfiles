{
  pkgs,
  lib,
  config,
  options,
  inputs,
  ...
}: {
  fonts.fontDir.enable = true;
  fonts.fonts = with pkgs; [
    font-awesome
    "${config.my.fonts.serif.package}"
  ];
}
