{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "damian";
  home.homeDirectory = "/home/damian";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = [
    pkgs.htop
    pkgs.bat
    pkgs.exa
    pkgs.starship
    pkgs.just
    pkgs.direnv
    pkgs.ripgrep
    pkgs.neovim
  ];

  home.file.".bashrc".source = ~/dotfiles/bashrc;
  home.file.".gitconfig".source = ~/dotfiles/gitconfig;
  home.file.".gitignore".source = ~/dotfiles/gitignore;
  home.file.".config/nvim/" = {
    source = ~/dotfiles/nvim;
    recursive = true;
  };
}
