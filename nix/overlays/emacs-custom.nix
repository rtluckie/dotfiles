{
  pkgs,
  fetchFromGitHub,
  darwin,
}: let
  emacsPlus = fetchFromGitHub {
    owner = "d12frosted";
    repo = "homebrew-emacs-plus";
    rev = "496c1a358122d17b141efbc9d370b12220aeb3d5";
    sha256 = "sha256-mz1FeBl3K8R/76HavMrUWuFlETv0j4IqXGmLrnAqsWk=";
  };
  patchesDir = emacsPlus + "/patches/emacs-28";
in
  pkgs.emacsGit.overrideAttrs (o: rec {
    pname = "emacsCustom";

    # # https://github.com/cmacrae/emacs/blob/03b4223e56e10a6d88faa151c5804d30b8680cca/flake.nix#L75
    buildInputs = o.buildInputs ++ [darwin.apple_sdk.frameworks.WebKit];

    # # https://github.com/siraben/nix-gccemacs-darwin/blob/f543cf1d30dc8afb895aaddfb73c92cb739874fe/emacs.nix#L16-L17
    configureFlags =
      o.configureFlags
      ++ [
        "--with-cairo"
        "--with-harfbuzz"
        # "--without-gpm"
        # "--without-dbus"
        # "--without-mailutils"
        # "--without-pop"
      ];

    patches = [
      "${patchesDir}/no-titlebar-and-round-corners.patch"
      "${patchesDir}/no-frame-refocus-cocoa.patch"
      "${patchesDir}/fix-window-role.patch"
      "${patchesDir}/system-appearance.patch"
    ];

    postPatch = ''
      ${o.postPatch}
      cp -f ${emacsPlus}/icons/modern-doom3.icns nextstep/Cocoa/Emacs.base/Contents/Resources/Emacs.icns
    '';

    # https://github.com/siraben/nix-gccemacs-darwin/blob/f543cf1d30dc8afb895aaddfb73c92cb739874fe/emacs.nix#L27-L29
    postInstall =
      o.postInstall
      + ''
        ln -snf $out/lib/emacs/${o.version}/native-lisp $out/Applications/Emacs.app/Contents/native-lisp
      '';

    CFLAGS = "-DMAC_OS_X_VERSION_MAX_ALLOWED=110203 -g -O3 -mtune=native -march=native -fomit-frame-pointer";

    meta.platforms = ["x86_64-darwin" "aarch64-darwin"];
  })
