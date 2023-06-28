{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.dircolors;
in {
  options = {
    modules.tools.dircolors = {
      enable =
        mkEnableOption "tools.dircolors"
        // {
          default = false;
        };
    };
  };
  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.user.programs.dircolors = rec {
        enable = true;
        enableZshIntegration = true;
        # https://github.com/trapd00r/LS_COLORS/blob/master/LS_COLORS
        settings = {
          "BLK" = "38;5;68";
          "CAPABILITY" = "38;5;17";
          "CHR" = "38;5;113;1";
          "DIR" = "38;5;30";
          "DOOR" = "38;5;127";
          "EXEC" = "38;5;208;1";
          "FIFO" = "38;5;126";
          "FILE" = "0";
          "LINK" = "target";
          "MULTIHARDLINK" = "38;5;222;1";
          # "NORMAL don't reset the bold attribute -
          # https://github.com/trapd00r/LS_COLORS/issues/11
          #NORMAL                38;5;254
          "NORMAL" = "0";
          "ORPHAN" = "48;5;196;38;5;232;1";
          "OTHER_WRITABLE" = "38;5;220;1";
          "SETGID" = "48;5;3;38;5;0";
          "SETUID" = "38;5;220;1;3;100;1";
          "SOCK" = "38;5;197";
          "STICKY" = "38;5;86;48;5;234";
          "STICKY_OTHER_WRITABLE" = "48;5;235;38;5;139;3";
          "*LS_COLORS" = "48;5;89;38;5;197;1;3;4;7";
          # }}}
          # documents {{{1
          "*README" = "38;5;220;1";
          "*README.rst" = "38;5;220;1;";
          "*README.md" = "38;5;220;1";
          "*LICENSE" = "38;5;220;1";
          "*COPYING" = "38;5;220;1";
          "*INSTALL" = "38;5;220;1";
          "*COPYRIGHT" = "38;5;220;1";
          "*AUTHORS" = "38;5;220;1";
          "*HISTORY" = "38;5;220;1";
          "*CONTRIBUTORS" = "38;5;220;1";
          "*PATENTS" = "38;5;220;1";
          "*VERSION" = "38;5;220;1";
          "*NOTICE" = "38;5;220;1";
          "*CHANGES" = "38;5;220;1";
          ".log" = "38;5;190";
          # plain-text {{{2
          ".txt" = "38;5;253";
          # markup {{{2
          ".adoc" = "38;5;184";
          ".asciidoc" = "38;5;184";
          ".etx" = "38;5;184";
          ".info" = "38;5;184";
          ".markdown" = "38;5;184";
          ".md" = "38;5;184";
          ".mkd" = "38;5;184";
          ".nfo" = "38;5;184";
          ".pod" = "38;5;184";
          ".rst" = "38;5;184";
          ".tex" = "38;5;184";
          ".textile" = "38;5;184";
          ".java" = "38;5;074;1";
          "*Dockerfile" = "38;5;155";
          ".dockerignore" = "38;5;240";
          "*Makefile" = "38;5;155";
          "*MANIFEST" = "38;5;243";
          # Functional Configuration
          ".nix" = "38;5;155";
          ".dhall" = "38;5;178";
        };
      };
    }
    {
      my.hm.user.programs.dircolors = {
        enableBashIntegration = true;
        enableFishIntegration = true;
        enableZshIntegration = true;
      };
    }
  ]);
}
