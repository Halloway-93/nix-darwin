{
  pkgs,
  config,
  ...
}: {
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment = {
    systemPackages = with pkgs; [
      vim
      zsh
      git
      cargo
      # alacritty
      neovim
      coreutils
      mkalias
      nodejs
    ];
    systemPath = [
    ];
    # pathsToLink = ["/Applications" " ~/Applications/Home Manager Apps/"];
  };
  homebrew = {
    enable = true;
    casks = ["ghostty"];
    onActivation.cleanup = "zap";
    onActivation.upgrade = true;
    onActivation.autoUpdate = true;
  };
  fonts.packages = [(pkgs.nerdfonts.override {fonts = ["IosevkaTerm" "JetBrainsMono"];})];
  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  nixpkgs.config.allowUnfree = true;

  nix = {
    optimise.automatic = true;
    package = pkgs.nix;
    settings.experimental-features = "nix-command flakes";
    gc = {
      automatic = true;
      options = "--delete-older-than- 10d";
    };
  };

  system.activationScripts.applications.text = let
    env = pkgs.buildEnv {
      name = "system-applications";
      paths =
        config.environment.systemPackages
        ++ (with config.home-manager.users.mango.home; packages);
      pathsToLink = "/Applications";
    };
  in
    pkgs.lib.mkForce ''
      # Set up Nix applications from both system and home-manager packages
      echo "Setting up Nix Applications..." >&2
      rm -rf /Applications/Nix\ Apps
      mkdir -p /Applications/Nix\ Apps

      # Find and link Nix-installed applications
      find ${env}/Applications -maxdepth 1 -type l | while read -r app; do
        src=$(readlink "$app")
        app_name=$(basename "$app")

        echo "Processing app: $app" >&2
        echo "  Symlink target: $src" >&2
        echo "  App name: $app_name" >&2

        if [[ -d "$src" ]]; then
          echo "Linking Nix app: $app_name" >&2
          ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
        else
          echo "WARN: Not linking $app_name - target is not a directory" >&2
        fi
      done
    '';
  system.defaults = {
    finder.AppleShowAllExtensions = true;
    finder._FXShowPosixPathInTitle = true;
    dock.autohide = true;
    NSGlobalDomain.AppleShowAllExtensions = true;
    NSGlobalDomain.InitialKeyRepeat = 15;
    NSGlobalDomain.KeyRepeat = 1;
    trackpad.Clicking = true; # This enables tap-to-click
  };
  # system.autoUpgrade = {
  #   enable = true;
  #   dates = "weekly";
  # };

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToEscape = true;
  };
  # Necessary for using flakes on this system.
  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true; # default shell on catalina

  # programs.fish.enable = true;

  # Set Git commit hash for darwin-version.
  # system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "x86_64-darwin";

  #Automatic cleanup
}
