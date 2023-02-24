{
  config,
  lib,
  pkgs,
  ...
}:
with pkgs.stdenv;
with lib; {
  system.stateVersion = "22.05";
  i18n.defaultLocale = "en_US.UTF-8";
  services.xserver.enable = true;
  services.xserver.autorun = true;
  services.xserver.autoRepeatDelay = 200;
  services.xserver.autoRepeatInterval = 25;
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  users.users.${config.my.username} = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = ["audio" "jackaudio" "wheel" "docker"]; # Enable ‘sudo’ for the user.
  };
  virtualisation.docker.enable = true;
}
