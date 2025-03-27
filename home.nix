{pkgs, ...}: {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    ripgrep
    lua
    lua51Packages.luarocks
    lazygit
    alejandra
    virtualenv
    # xquartz
    # obsidian
    # portfolio
    # mattermost
    # alacritty-theme
    fd
    zotero
    tree-sitter
    neofetch
    sshfs
    # nodejs
    ffmpeg_7
    swift
    # ollama
    # fabric-ai
    # llama-cpp
    go
    R
    pandoc
    #pdf viewer
    zathura
    imagemagick
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
    # ".config/alacritty/themes" = {
    #   source = pkgs.alacritty-theme;
    #   recursive = true;
    # };
    ".config/zsh/plugins" = {
      source = pkgs.zsh-fzf-tab;
      recursive = true;
    };
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/leh/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs = {
    home-manager.enable = true;
    fzf = {enable = true;};
    zsh = {
      enable = true;
      shellAliases = {
        vim = "nvim";
        ".." = "cd ..";
        ll = "ls -l";
        envau = "~/envau.sh";
        hpc = "~/hpc.sh";
        py = "source ~/.venv/main/bin/activate";
        psy = "source ~/.venv/psychopy/bin/activate";
        ls = "ls --color";
      };

      # export DISPLAY=:0 # Add back into extra if one wants to add xquartz and xorg
      # xhost +local:
      initExtra = ''
                source ~/.config/zsh/plugins/share/fzf-tab/fzf-tab.plugin.zsh
            export PATH=$PATH:/Users/mango/.local/share/nvim/lazy/zotcite/python3
        export PATH=$PATH:/usr/local/texlive/2025/bin/universal-darwin

      '';

      plugins = [
        {
          name = "zsh-fzf-tab";
          src = pkgs.fetchFromGitHub {
            owner = "Aloxaf";
            repo = "fzf-tab";
            rev = "1.1.2";
            sha256 = "Qv8zAiMtrr67CbLRrFjGaPzFZcOiMVEFLg1Z+N6VMhg=";
          };
        }
        {
          name = "zsh-vi-mode";

          src = pkgs.fetchFromGitHub {
            owner = "jeffreytse";
            repo = "zsh-vi-mode";
            rev = "0.11.0";
            sha256 = "sha256-xbchXJTFWeABTwq6h4KWLh+EvydDrDzcY9AQVK65RS8=";
          };
        }
      ];

      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
    };
    # kitty settings
    kitty = {
      enable = true;
      shellIntegration.enableZshIntegration = true;
      font = {
        # name = "JetBrainsMono Nerd Font";
        name = "IosevkaTerm Nerd Font Mono Regular";
        size = 16;
      };
      keybindings = {
        "cmd+]" = "next_window";
        "cmd+[" = "previous_window";
        "cmd+f" = "toggle_maximized";
      };
      # themeFile = "Catppuccin-Mocha";
      themeFile = "BlackMetal";
      settings = {
        enabled_layouts = "horizontal,fat,grid,stack,tall,vertical,splits";
        disable_ligatures = "never";
        macos_option_as_alt = "both";
        allow_remote_control = "yes";
        listen_on = "unix:/tmp/mykitty";
        # background_opacity = 0.5;
        # background_blur = 50;
      };
    };
    # ghostty = {
    #   enable = true;
    #   enableZshIntegration = true;
    #   settings = {
    #     theme = "catppuccin_mocha";
    #     fontsize = 14;
    #   };
    # };

    #alacritty settings:
    # alacritty = {
    #   enable = true;
    #   settings = {
    #     window = {
    #       decorations = "Buttonless";
    #       opacity = 0.5;
    #       blur = true;
    #       option_as_alt = "Both";
    #     };
    #     font = {
    #       normal.family = "IosevkaTerm Nerd Font Mono";
    #       normal.style = "SemiBold";
    #       size = 20;
    #     };
    #     general.import = ["~/.config/alacritty/themes/catppuccin_mocha.toml"];
    #
    #     keyboard = {
    #       bindings = [
    #         {
    #           key = "Enter";
    #           mods = "Command";
    #           action = "ToggleSimpleFullscreen";
    #         }
    #       ];
    #     };
    #   };
    # };
    # zellij = {
    #   enable = true;
    #   enableZshIntegration = true;
    #   settings = {
    #     theme = "catppuccin-mocha";
    #
    #     default_layout = "compact";
    #     ui = {
    #       pane_frames = {
    #         rounded_corners = true;
    #         hide_session_name = true;
    #       };
    #     };
    #   };
    # };
    #starship settings:
    starship = {
      enable = true;
      settings = {
        username = {
          style_user = "blue bold";
          style_root = "red bold";
          format = "[$user]($style) ";
          disabled = false;
          show_always = true;
        };
        hostname = {
          ssh_only = false;
          ssh_symbol = "🌐 ";
          format = "on [$hostname](bold red) ";
          trim_at = ".local";
          disabled = false;
        };
        format = "$directory$character";
        right_format = "$all";
      };
    };
    git = {
      enable = true;
      userName = "Halloway-93";
      userEmail = "hamzaelhallaoui@gmail.com";
      ignores = [".DS_Store"];
    };
  };
}
