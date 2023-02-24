{
  pkgs,
  lib,
  config,
  ...
}: let
  defaultLang = "en_US.UTF-8";
in {
  fonts.fontconfig.enable = true;
  home.username = config.my.username;
  home.homeDirectory = config.my.homeDirectory;
  home.stateVersion = "23.05";
  home.language.base = "${defaultLang}";
  home.language.ctype = "${defaultLang}";
  home.language.numeric = "${defaultLang}";
  home.language.time = "${defaultLang}";
  home.language.collate = "${defaultLang}";
  home.language.monetary = "${defaultLang}";
  home.language.messages = "${defaultLang}";
  home.language.paper = "${defaultLang}";
  home.language.name = "${defaultLang}";
  home.language.address = "${defaultLang}";
  home.language.telephone = "${defaultLang}";
  home.language.measurement = "${defaultLang}";
}
