{pkgs, ...}: {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello
    ripgrep
    lua
    fzf
		sshpass
    # nodejs
    # gitleaks
    lua51Packages.luarocks
    lazygit
    obsidian
    alejandra
    neovim
    virtualenv
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
    # home-manager.path="$HOME/.config/sys-config/home-manager";
    zsh = {
      enable = true;
      shellAliases = {
        vim = "nvim";
        ".." = "cd ..";
        ll = "ls -l";
        envau = "~/envau.sh";
        hpc = "~/hpc.sh";
				py="source ~/venvs/main/bin/activate";
				psy="source ~/venvs/psychopy/bin/activate";
      };

      plugins = [
        {
          name = "zsh-autocomplete";

          src = pkgs.fetchFromGitHub {
            owner = "marlonrichert";
            repo = "zsh-autocomplete";
            rev = "23.07.13";
            sha256 = "sha256-0NW0TI//qFpUA2Hdx6NaYdQIIUpRSd0Y4NhwBbdssCs=";
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

        # {
        #   name = "zsh-fzf-tab";
        #   src = pkgs.fetchFromGitHub {
        #     owner = "Aloxaf";
        #     repo = "fzf-tab";
        #     rev = "1.1.2";
        #     hash = "sha256-Qv8zAiMtrr67CbLRrFjGaPzFZcOiMVEFLg1Z+N6VMhg=";
        #   };
        # }
      ];

      # initExtra = ''bindkey "''${key[Up]}" up-line-or-search'';
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
    };
    #alacritty settings:
    alacritty = {
      enable = true;
      settings = {
        window = {
          decorations = "Buttonless";
          opacity = 0.5;
          blur = true;
          option_as_alt = "Both";
        };
        font = {
          normal.family = "IosevkaTerm Nerd Font Mono";
          normal.style = "SemiBold";
          size = 20;
        };

        colors = {
          primary = {
            background = "#1E1E2E"; # base
            foreground = "#CDD6F4"; # text
            dim_foreground = "#CDD6F4"; # text
            bright_foreground = "#CDD6F4"; # text
          };

          cursor = {
            text = "#1E1E2E"; # base
            cursor = "#F5E0DC"; # rosewater
          };

          vi_mode_cursor = {
            text = "#1E1E2E"; # base
            cursor = "#B4BEFE"; # lavender
          };

          normal = {
            black = "#45475A"; # surface1
            red = "#F38BA8"; # red
            green = "#A6E3A1"; # green
            yellow = "#F9E2AF"; # yellow
            blue = "#89B4FA"; # blue
            magenta = "#F5C2E7"; # pink
            cyan = "#94E2D5"; # teal
            white = "#BAC2DE"; # subtext1
          };

          bright = {
            black = "#585B70"; # surface2
            red = "#F38BA8"; # red
            green = "#A6E3A1"; # green
            yellow = "#F9E2AF"; # yellow
            blue = "#89B4FA"; # blue
            magenta = "#F5C2E7"; # pink
            cyan = "#94E2D5"; # teal
            white = "#A6ADC8"; # subtext0
          };

          dim = {
            black = "#45475A"; # surface1
            red = "#F38BA8"; # red
            green = "#A6E3A1"; # green
            yellow = "#F9E2AF"; # yellow
            blue = "#89B4FA"; # blue
            magenta = "#F5C2E7"; # pink
            cyan = "#94E2D5"; # teal
            white = "#BAC2DE";
          };

          hints = {
            start = {
              foreground = "#1E1E2E"; # base
              background = "#F9E2AF"; # yellow
            };
            end = {
              foreground = "#1E1E2E"; # base
              background = "#A6ADC8"; # subtext0
            };
          };

          selection = {
            text = "#1E1E2E"; # base
            background = "#F5E0DC"; # rosewater
          };

          search = {
            matches = {
              foreground = "#1E1E2E"; # base
              background = "#A6ADC8"; # subtext0
            };
            focused_match = {
              foreground = "#1E1E2E"; # base
              background = "#A6E3A1"; # green
            };
          };
          footer_bar = {
            foreground = "#1E1E2E"; # base
            background = "#A6ADC8"; # subtext0
          };
        };
        keyboard = {
          bindings = [
            {
              key = "Enter";
              mods = "Command";
              action = "ToggleSimpleFullscreen";
            }
          ];
        };
      };
    };
    zellij = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        theme = "catppuccin-mocha";

        default_layout = "compact";
        ui = {
          pane_frames = {
            rounded_corners = true;
            hide_session_name = true;
          };
        };
      };
    };
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
