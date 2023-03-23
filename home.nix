{ config, pkgs, ... }:

{
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
    pkgs.fd
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
    profileExtra = ''
      if [ -e /home/damian/.nix-profile/etc/profile.d/nix.sh ]; then . /home/damian/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
    '';
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
    '';
  };

  programs.starship.enable = true;
  programs.direnv.enable = true;

  # Ctrl-r for fuzzy find cmd history
  # Ctrl-t for finding file paths
  # Alt-c for fuzzy finding cd
  programs.fzf.enable = true;

  programs.git = {
    enable = true;
    package = pkgs.gitFull;

    userName = "damszew";
    userEmail = "damian.szewczyk111@gmail.com";
    aliases = {
      s = "status -s";
      l = "log --decorate --oneline -10 --graph";
      b = "branch";
      showfiles = "show --name-only";
    };
    extraConfig = {
      credential.helper = "libsecret";
      format.pretty = "format:%C(yellow)%h%Creset -%C(bold red)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset";
    };
  };

  home.file.".config/nvim/" = {
    source = ~/dotfiles/nvim;
    recursive = true;
  };
}
