{
  lib,
  pkgs,
  config,
  services,
  ...
}: {
  my.hostname = "gull";
  # modules.lang.go.enable = true;
  # modules.lang.jsonnet.enable = true;
  # modules.lang.python.enable = true;
  # modules.misc.media.enable = true;
  # modules.term.alacritty.enable = true;
  # modules.term.gpg.enable = true;
  # modules.term.ssh.enable = true;
  # modules.term.starship.enable = true;
  # modules.term.tmux.enable = true;
  # modules.term.zsh.enable = true;
  # modules.tools.bat.enable = true;
  # modules.tools.dircolors.enable = true;
  # modules.tools.direnv.enable = true;
  # modules.tools.fzf.enable = true;
  # modules.tools.git.enable = true;
  # modules.tools.homebrew.enable = true;
  # modules.tools.pet.enable = true;
  # modules.tools.text.enable = true;
  # modules.tools.k8s.enable = true;
  # modules.tools.yabai.enable = true;
  # modules.tools.skhd.enable = true;
  modules.editors.emacs.enable = true;
}
