{ config
, pkgs
, ...
}: {
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
  home.stateVersion = "23.11";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    htop
    bat
    eza
    just
    ripgrep
    lazygit
    git-branchless
    fd
    jq
    vscode # May cause problems with extensions on NixOS
    spotify
    # obsidian # https://github.com/NixOS/nixpkgs/issues/273611
    discord
    # ubuntu_font_family
    commit-mono
    taplo
    slack
    google-chrome
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
    sessionVariables = { BROWSER = "google-chrome"; };

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
  programs.fish = {
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
    interactiveShellInit = ''
      set -U fish_greeting

      fish_add_path /home/damian/.cargo/bin

      fish_config theme choose "Dracula Official"
    '';
  };
  home.file."${config.xdg.configHome}/fish/themes/Dracula Official.theme" = {
    source = pkgs.fetchFromGitHub
      {
        owner = "dracula";
        repo = "fish";
        rev = "269cd7d76d5104fdc2721db7b8848f6224bdf554";
        sha256 = "Hyq4EfSmWmxwCYhp3O8agr7VWFAflcUe8BUKh50fNfY=";
      } + "/themes/Dracula Official.theme";
  };

  programs.starship.enable = true;
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

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

        lsp = { display-inlay-hints = true; };

        indent-guides = {
          render = true;
          character = "┊"; # "▏", "┆", "┊", "⸽"
        };
      };

      keys.normal = {
        A-j = [ "extend_to_line_bounds" "delete_selection" "paste_after" ];
        A-k = [
          "extend_to_line_bounds"
          "delete_selection"
          "move_line_up"
          "paste_before"
        ];
        esc = [ "collapse_selection" "keep_primary_selection" ];
      };
    };

    languages = {
      language = [
        {
          name = "nix";
          auto-format = true;
          formatter.command = "alejandra"; # For some reason `nil` doesn't fmt devenv.nix;
        }
        {
          name = "toml";
          auto-format = true;
        }
        {
          name = "rust";
          auto-pairs = {
            "(" = ")";
            "{" = "}";
            "[" = "]";
            "\"" = "\"";
            "`" = "`";
            "<" = ">";
          };
        }
      ];
    };
  };

  home.file."${config.xdg.configHome}/wezterm/wezterm.lua" = {
    source = ./wezterm.lua;
  };

  dconf.settings = {
    "org/gnome/shell" = {
      favorite-apps = [
        "org.gnome.Nautilus.desktop"
        "code.desktop"
        "google-chrome.desktop"
        "1password.desktop"
        "discord.desktop"
      ];
    };
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      enable-hot-corners = false;
    };

    "org/gnome/desktop/background" = {
      picture-uri = "file:///home/damian/dotfiles/wallpaper.png";
      picture-uri-dark = "file:///home/damian/dotfiles/wallpaper.png";
    };

    "org/gnome/desktop/wm/keybindings" = {
      close = [ "<Super>q" ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      binding = "<Super>Return";
      command = "x-terminal-emulator";
      name = "Open terminal";
    };
  };

  # services.dropbox.enable = true;

  targets.genericLinux.enable = true;
  fonts.fontconfig.enable = true;
}
