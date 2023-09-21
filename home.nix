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
    pkgs.eza
    pkgs.just
    pkgs.ripgrep
    pkgs.neovim
    pkgs.lazygit
    pkgs.git-branchless
    pkgs.fd
    pkgs.vscode # May cause problems with extensions on NixOS
    pkgs.spotify
    pkgs.obsidian
    # pkgs.ubuntu_font_family
    pkgs.commit-mono
  ];

  programs.bash = {
    enable = true;
    shellAliases = {
      ls = "eza";
      ll = "eza --all --long --classify";
      la = "eza --all";
      lt = "eza --tree";

      cat = "bat -p";
      grep = "rg";

      cp = "cp -v";
      mv = "mv -v";
      rm = "rm -v";

    };
    sessionVariables = {
      BROWSER = "google-chrome";
    };

    bashrcExtra = ''
      . ~/dotfiles/bashrc
      . $HOME/.cargo/env # normally rustup installs it

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
      push.autoSetupRemote = true;
      credential.helper = "libsecret";
      format.pretty = "format:%C(yellow)%h%Creset -%C(bold red)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset";
    };
  };

  programs.helix = {
    enable = true;
    defaultEditor = true;

    settings = {
      theme = "dracula";

      editor = {
        line-number = "relative";
        cursorline = true;
        bufferline = "multiple";

        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };

        lsp = {
          display-inlay-hints = true;
        };

        indent-guides = {
          render = true;
          character = "┊"; # "▏", "┆", "┊", "⸽"
        };
      };

      keys.normal = {
        A-j = [ "extend_to_line_bounds" "delete_selection" "paste_after" ];
        A-k = [ "extend_to_line_bounds" "delete_selection" "move_line_up" "paste_before" ];
        esc = [ "collapse_selection" "keep_primary_selection" ];
      };
    };
  };

  home.file."${config.xdg.configHome}/nvim/" = {
    source = ~/dotfiles/nvim;
    recursive = true;
  };
  home.file."${config.xdg.configHome}/wezterm/wezterm.lua" = {
    source = ~/dotfiles/wezterm.lua;
  };

  targets.genericLinux.enable = true;
  fonts.fontconfig.enable = true;
}
