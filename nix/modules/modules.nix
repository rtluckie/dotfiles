# why not use stdenv isDarwin function
# https://github.com/nix-community/home-manager/issues/414
{
  lib,
  isDarwin ? false,
  isNixOS ? false,
}:
with lib; let
  loadModule = file: {condition ? true}: {inherit file condition;};
  allModules = [
    (loadModule ./editors/emacs.nix {})
    (loadModule ./gui/_1password.nix {})
    (loadModule ./gui/amethyst.nix {})
    (loadModule ./gui/brave-browser.nix {})
    (loadModule ./gui/discord.nix {})
    (loadModule ./gui/google-drive.nix {})
    (loadModule ./gui/istat-menus.nix {})
    (loadModule ./gui/keycastr.nix {})
    (loadModule ./gui/lens.nix {})
    (loadModule ./gui/little-snitch.nix {})
    (loadModule ./gui/nordvpn.nix {})
    (loadModule ./gui/postman.nix {})
    (loadModule ./gui/qbittorrent.nix {})
    (loadModule ./gui/raycast.nix {})
    (loadModule ./gui/rectangle.nix {})
    (loadModule ./gui/rescuetime.nix {})
    (loadModule ./gui/signal.nix {})
    (loadModule ./gui/slack.nix {})
    (loadModule ./gui/spotify.nix {})
    (loadModule ./gui/vlc.nix {})
    (loadModule ./gui/vscode.nix {})
    (loadModule ./gui/wireguard.nix {})
    (loadModule ./gui/zoom.nix {})
    (loadModule ./lang/go.nix {})
    (loadModule ./lang/jsonnet.nix {})
    (loadModule ./lang/nix.nix {})
    (loadModule ./lang/node.nix {})
    (loadModule ./lang/python.nix {})
    (loadModule ./lang/rust.nix {})
    (loadModule ./misc/apps.nix {})
    (loadModule ./misc/media.nix {})
    (loadModule ./options.nix {})
    (loadModule ./term/alacritty.nix {})
    (loadModule ./term/gpg.nix {})
    (loadModule ./term/ssh.nix {})
    (loadModule ./term/starship.nix {})
    (loadModule ./term/tmux.nix {})
    (loadModule ./term/utils.nix {})
    (loadModule ./term/wezterm.nix {})
    (loadModule ./term/zsh.nix {})
    (loadModule ./tools/bat.nix {})
    (loadModule ./tools/compression.nix {})
    (loadModule ./tools/dev.nix {})
    (loadModule ./tools/dircolors.nix {})
    (loadModule ./tools/direnv.nix {})
    (loadModule ./tools/dyff.nix {})
    (loadModule ./tools/exa.nix {})
    (loadModule ./tools/fd.nix {})
    (loadModule ./tools/fzf.nix {})
    (loadModule ./tools/gcloud.nix {})
    (loadModule ./tools/git.nix {})
    (loadModule ./tools/helix.nix {})
    (loadModule ./tools/homebrew.nix {})
    (loadModule ./tools/jq.nix {})
    (loadModule ./tools/k8s.nix {})
    (loadModule ./tools/misc.nix {})
    (loadModule ./tools/network.nix {})
    (loadModule ./tools/pet.nix {})
    (loadModule ./tools/podman.nix {})
    (loadModule ./tools/qemu.nix {})
    (loadModule ./tools/ripgrep.nix {})
    (loadModule ./tools/skhd.nix {})
    (loadModule ./tools/terraform.nix {})
    (loadModule ./tools/text.nix {})
    (loadModule ./tools/treefmt.nix {})
    (loadModule ./tools/utils.nix {})
    (loadModule ./tools/xh.nix {})
    (loadModule ./tools/yabai.nix {})
    (loadModule ./tools/yubikey.nix {})
    (loadModule ./tools/zoxide.nix {})
  ];
  modules = map (getAttr "file") (filter (getAttr "condition") allModules);
in
  modules
