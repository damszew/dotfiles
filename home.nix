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
    pkgs.just
    pkgs.ripgrep
    pkgs.neovim
    pkgs.lazygit
    pkgs.git-branchless
  ];

  programs.bash = {
    enable = true;
    shellAliases = {
      ls = "exa";
      ll = "exa --all --long --classify";
      la = "exa --all";
      lt = "exa --tree";

      cat = "bat -p";
      grep = "rg";

      cp = "cp -v";
      mv = "mv -v";
      rm = "rm -v";

    };
    sessionVariables = {
      EDITOR = "nvim";
      BROWSER = "google-chrome";
    };
    bashrcExtra = ''
      . ~/dotfiles/bashrc
      . $HOME/.cargo/env # normally rustup installs it


      eval "$(just --completions bash)" # never versions of nixpkgs install this automatically

      extract () {
        if [ -f $1 ] ; then
          case $1 in
            *.tar.bz2)	tar xjf $1		;;
            *.tar.gz)	tar xzf $1		;;
            *.bz2)		bunzip2 $1		;;
            *.rar)		rar x $1		;;
            *.gz)		gunzip $1		;;
            *.tar)		tar xf $1		;;
            *.tbz2)		tar xjf $1		;;
            *.tgz)		tar xzf $1		;;
            *.zip)		unzip $1		;;
            *.Z)		uncompress $1	;;
            *)			echo "'$1' cannot be extracted via extract()" ;;
         esac
        else
          echo "'$1' is not a valid file"
        fi
      }

      psgrep() {
        if [ ! -z $1 ] ; then
          echo "Looking for processes matching $1..."
          ps aux | rg -v rg | rg $1
        else
          echo "!! Need process to look for"
        fi
      }

      ff() {
        if [ ! -z $1 ] ; then
          echo "Trying to fing file matching *$1*..."
          find . -name *$1* -print
        else
          echo "!! Need file to look for"
        fi
      }

    '';
  };

  programs.starship.enable = true;
  programs.direnv.enable = true;

  home.file.".gitconfig".source = ~/dotfiles/gitconfig;
  home.file.".gitignore".source = ~/dotfiles/gitignore;
  home.file.".config/nvim/" = {
    source = ~/dotfiles/nvim;
    recursive = true;
  };
}
