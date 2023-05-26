{
  pkgs,
  lib,
  config,
  options,
  inputs,
  ...
}: let
  cfg = config.modules.editors.emacs.doom;
in {
  options = with lib; {
    modules.editors.emacs.doom = {
      enable =
        mkEnableOption "editors.emacs.doom"
        // {
          default = false;
        };
    };
  };

  config = with lib;
    mkIf config.modules.editors.emacs.enable (mkMerge [
      {
        environment.systemPackages = with pkgs; [
        ];
        my.hm.user = {
          home = {
            sessionPath = ["$HOME/.config/emacs/bin"];
            sessionVariables = {
              DOOMDIR = "$HOME/.config/doom";
              DOOMLOCALDIR = "$HOME/.config/doom-local";
              DOOMPROFILELOADFILE = "$HOME/.config/doom-local/profiles/load.el";
            };
            packages = with pkgs; [
            ];
          };
        };
      }
      {
        my.hm.user.home.activation.emacsDoom = inputs.home-manager.lib.hm.dag.entryAfter ["writeBoundary"] ''
          if [[ ! -d "$HOME/.config/emacs" ]]; then
          ${pkgs.git}/bin/git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
          fi
        '';
      }
      {
        my.hm.configFile."doom/snippets" = {
          source = "${config.my.dotfiles.configDir}/doom/snippets";
          recursive = true;
        };
      }
      {
        my.hm.configFile."doom/init.el".text =
          lib.concatStringsSep "\n"
          [
            ";; ${config.my.nixManaged}"
            (
              lib.concatStringsSep "\n"
              (
                map builtins.readFile [
                  "${config.my.dotfiles.configDir}/doom/init.el"
                ]
              )
            )
          ];
      }
      {
        my.hm.configFile."doom/packages.el".text =
          lib.concatStringsSep "\n"
          [
            ";; ${config.my.nixManaged}"
            (
              lib.concatStringsSep "\n"
              (
                map builtins.readFile [
                  "${config.my.dotfiles.configDir}/doom/packages.el"
                ]
              )
            )
          ];
      }

      {
        my.hm.configFile."doom/config.org".text = lib.concatStringsSep "\n" [
          ";; ${config.my.nixManaged}"
          ''
            #+TITLE: doomemacs literate configuration

            * doomemacs literate configuration

            According to [[https://nullprogram.com/blog/2016/12/22/][this blog]], this lexical-binding can improve performance.

            #+begin_src elisp
            ;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
            #+end_src

            User identification. You can find more information in the [[https://www.gnu.org/software/emacs/manual/html_node/elisp/User-Identification.html][official documentation]].

            #+begin_src elisp
            (setq user-full-name "${config.my.name}" )
            (setq  user-mail-address "${config.my.email}" )
            (setq user-username "${config.my.githubUsername}" )
            (setq user-github-username user-username )

            (setq
              doom-font (font-spec :family "${config.my.fonts.mono.name}" :size ${toString config.my.fonts.mono.size})
              doom-big-font (font-spec :family "${config.my.fonts.big.name}" :size ${toString config.my.fonts.big.size})
              doom-serif-font (font-spec :family "${config.my.fonts.serif.name}" :size ${toString config.my.fonts.serif.size})
              doom-unicode-font (font-spec :family "${config.my.fonts.unicode.name}" :size ${toString config.my.fonts.unicode.size})
              doom-variable-pitch-font (font-spec :family "${config.my.fonts.variablePitch.name}" :size ${toString config.my.fonts.variablePitch.size})
              )
            #+end_src
          ''
          (
            lib.concatStringsSep "\n"
            (
              map builtins.readFile [
                "${config.my.dotfiles.configDir}/doom/config.org"
              ]
            )
          )
        ];
      }
    ]);
}
