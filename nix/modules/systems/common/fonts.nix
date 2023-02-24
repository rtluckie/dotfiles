{pkgs, ...}: {
  fonts.fontDir.enable = true;
  fonts.fonts = with pkgs; [
    fira-code
    font-awesome
    iosevka
  ];
}
