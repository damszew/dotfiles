{ config, pkgs, nixgl, ... }: {
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
  home.stateVersion = "24.05";

  home.sessionVariables = {
    BROWSER = "google-chrome";
    EDITOR = "hx";

    # Fix for `git-bug` not using `IdentityAgent`
    SSH_AUTH_SOCK = "${config.home.homeDirectory}/.1password/agent.sock";

    # Wayland: Electron apps (VSCode, Slack, Discord, Obsidian)
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";

    # Wayland: Firefox / Mozilla apps
    MOZ_ENABLE_WAYLAND = "1";

    # Wayland: Qt apps (prefer Wayland, fall back to XCB/X11)
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

    # Wayland: GTK apps (prefer Wayland, fall back to X11)
    GDK_BACKEND = "wayland,x11";
  };

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    htop
    bat
    eza
    just
    ripgrep
    lazygit
    fd
    jq
    gh
    devenv
    git-branchless
    vscode
    spotify
    obsidian
    discord
    # ubuntu_font_family
    commit-mono
    taplo
    slack
  ];

  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host *
          IdentityAgent ~/.1password/agent.sock
    '';
  };

  programs.fish = {
    enable = true;
    shellAliases = {
      l = "eza -l --icons --git -a";
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
      fish_add_path /home/damian/.local/bin

      # devenv hook fish | source

      # DraculaDynamic ships [light]/[dark] blocks; fish picks the block that
      # matches $fish_terminal_color_theme (the terminal's reported background).
      fish_config theme choose DraculaDynamic
    '';
    functions = {
      # Reapply the theme whenever the terminal switches between a light and
      # dark background, so open shells follow the system theme live.
      _update_fish_theme = {
        body = ''fish_config theme choose DraculaDynamic'';
        onVariable = "fish_terminal_color_theme";
        description = "Reapply DraculaDynamic when the terminal's light/dark background changes";
      };
    };
  };
  home.file."${config.xdg.configHome}/fish/themes/DraculaDynamic.theme".source =
    ./fish/themes/DraculaDynamic.theme;

  programs.starship.enable = true;
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.wezterm = {
    enable = true;
    package = config.lib.nixGL.wrap pkgs.wezterm;
    extraConfig = builtins.readFile ./wezterm.lua;
  };

  # Ctrl-r for fuzzy find cmd history
  # Ctrl-t for finding file paths
  # Alt-c for fuzzy finding cd
  programs.fzf.enable = true;
  programs.zoxide = {
    enable = true;
    options = [ "--cmd cd" ];
  };

  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "damszew";
        email = "damian.szewczyk111@gmail.com";
      };

      alias = {
        s = "status -s";
        l = "log --decorate --oneline -10 --graph";
        lb = "l --branches";
        b = "branch";
        showfiles = "show --name-only";
        amend = "commit --amend --all --no-edit";
        co = "checkout";
        cr = "cherry-pick";
      };

      push.autoSetupRemote = true;
      credential.helper = "store";
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

  dconf.settings = {
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

  targets.genericLinux = {
    enable = true;
    nixGL.packages = nixgl.packages;
  };
  fonts.fontconfig.enable = true;
}
