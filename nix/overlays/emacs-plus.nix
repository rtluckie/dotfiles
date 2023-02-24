{
  emacsUnstable,
  fetchFromGitHub,
  darwin,
}: let
  emacsPlus = fetchFromGitHub {
    owner = "d12frosted";
    repo = "homebrew-emacs-plus";
    rev = "61d588ce80fb4282e107f5ab97914e32451c3da1";
    sha256 = "sha256-xJYEGu9wnndEhUTMVKiFPL1jwq+T6yEoZdYi5A1TTFQ=";
  };
  patchesDir = emacsPlus + "/patches/emacs-28";
in
  emacsUnstable.overrideAttrs (o: rec {
    pname = "emacsPlusNativeComp";

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

    # CFLAGS = "-DMAC_OS_X_VERSION_MAX_ALLOWED=110203 -g -O3 -mtune=native -march=native -fomit-frame-pointer";
    meta.platforms = ["x86_64-darwin" "aarch64-darwin"];
  })
