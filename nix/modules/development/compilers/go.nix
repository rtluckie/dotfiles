{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.development.compilers.go;

  goPackages = {
    mixtool = pkgs.buildGoModule rec {
      pname = "mixtool";
      version = "main";
      # goPackagePath = ".";
      # goPackagePath = "github.com/monitoring-mixin/mixtool";

      src = pkgs.fetchFromGitHub {
        owner = "monitoring-mixins";
        repo = "mixtool";
        rev = "${version}";
        sha256 = "sha256-jZjbt0zBPdsb/xl72yRLp8IKGDf4916YzK2WHJwl9HE=";
      };

      vendorSha256 = "sha256-8cJeU8KfonnreIHHFeDJmz6bpjBtuX2DZ44kwFwxaFg=";
      # deleteVendor = true;
      postConfigure = ''
        export CGO_ENABLED=0
      '';

      ldflags = ["-s" "-w" "-extldflags '-static'"];
      # subPackages = ["mixtool"];
    };
    xk6 = pkgs.buildGoModule rec {
      pname = "xk6";
      version = "master";
      # goPackagePath = ".";
      # goPackagePath = "github.com/monitoring-mixin/mixtool";

      src = pkgs.fetchFromGitHub {
        owner = "grafana";
        repo = "xk6";
        rev = "${version}";
        sha256 = "sha256-jZjbt0zBPdsb/xl72yRLp8IKGDf4916YzK2WHJwl9HE=";
      };

      vendorSha256 = "sha256-8cJeU8KfonnreIHHFeDJmz6bpjBtuX2DZ44kwFwxaFg=";
      # deleteVendor = true;
      postConfigure = ''
        export CGO_ENABLED=0
      '';

      ldflags = ["-s" "-w" "-extldflags '-static'"];
      # subPackages = ["cmd/xk6"];
    };
  };
in {
  options = {
    modules.development.compilers.go = {
      enable = mkEnableOption "development.compilers.go" // {default = true;};
    };
  };
  config = mkIf cfg.enable (mkMerge [
    {
      # my.hm.user.home.sessionVariables.GO111MODULE = "on";
      my.hm.user.programs.go = rec {
        # shellHook = ''export GO111MODULE="on"'';
        enable = true;
        goPath = ".local/share/go";
        goBin = ".local/bin/go";
        packages = goPackages;
      };
    }
    {
      my.hm.user.home.packages = with pkgs; [
        gocode
        godef
        gofumpt
        gomodifytags
        gopls
        gore
        gotests
        gotools
      ];
    }
    {
      my.hm.user.home = {
        sessionPath = [
          "$HOME/.local/bin/go"
        ];
        sessionVariables = {
        };
      };
    }
    {
      my.hm.user.programs.zsh.oh-my-zsh.plugins = [
        "golang"
      ];
    }
  ]);
}
