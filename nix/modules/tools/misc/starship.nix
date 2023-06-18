{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.misc.starship;
in {
  options = {
    modules.tools.misc.starship = {
      enable =
        mkEnableOption "tools.misc.starship"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      # home.packages = [ pkgs.zsh ];
      my.hm.user.programs.starship = rec {
        enable = true;
        enableZshIntegration = true;
        settings = {
          add_newline = false;
          format = lib.concatStrings [
            "$directory"
            "$fill"
            "($kubernetes | )"
            "(($aws)(|$gcp) | )"
            "($git_branch( | $git_commit)( | $git_state)( | $git_status) | )"
            "$time( | $cmd_duration )(| $status  )"
            "$line_break"
            "$character"
          ];
          scan_timeout = 1000;
          command_timeout = 2000;
          aws = {
            disabled = false;
            format = "$symbol [($profile )(\($region\) )]($style)";
            style = "bold blue";
            symbol = "🅰 ";
            region_aliases = {
              ap-southeast-2 = "au";
              us-east-1 = "va";
            };
            profile_aliases = {
              rtluckie_personal = "personal";
            };
          };
          cmd_duration = {
            disabled = false;
            format = "[$duration]($style)";
            style = "dimmed green";
            min_time = 2000;
          };
          gcloud = {
            disabled = false;
            format = "[$symbol$account(@$domain)(\($project\))]($style)";
            symbol = "️🇬️ ";
            region_aliases = {
              us-central1 = "uc1";
            };
          };
          directory = {
            read_only = " ";
            truncation_length = 100;
            truncate_to_repo = false;
          };
          fill = {
            symbol = " ";
          };
          status = {
            disabled = false;
            # style = "bg:blue";
            symbol = "👎";
            success_symbol = "👍";
            format = "[$symbol]($style)";
            map_symbol = true;
          };
          git_branch = {
            disabled = false;
            format = "[$symbol](dimmed yellow) [$branch(:$remote_branch)](dimmed green)";
            symbol = "";
            only_attached = true;
            # truncation_length = 4;
            # truncation_symbol = "";
            ignore_branches = [
              # "master"
              # "main"
            ];
          };
          git_commit = {
            disabled = false;
          };
          git_status = {
            ahead = "⇡($count)";
            behind = "⇣($count)";
            conflicted = "🏳";
            deleted = "🗑";
            diverged = "⇕⇡($ahead_count)⇣($behind_count)";
            modified = "!($count)";
            renamed = "👅";
            staged = "[++\($count\)](green)";
            stashed = "📦";
            untracked = "🤷";
            up_to_date = "✓";
            format = "([$all_status$ahead_behind]($style))";
          };
          python = {
            disabled = true;
          };
          kubernetes = {
            disabled = false;
            format = "⛵ [$context](dimmed yellow)(/[\($namespace\)](dimmed green))";
            context_aliases = {
              "gke_.*_.*_ec-us-central1-(?P<var_cluster>.+)" = "$var_cluster";
            };
            user_aliases = {
              "dev.local.cluster.k8s" = "dev";
              "root/.*" = "root";
            };
            detect_files = [
              ".k8s"
            ];
          };
          time = {
            disabled = false;
            format = "[$time]($style)";
            time_format = "%Y.%m.%d %H:%M";
            style = "dimmed yellow";
          };
        };
      };
    }
  ]);
}
