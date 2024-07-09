{
  pkgs,
  self,
  ...
}: {
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    vim
    zsh
    git
		cargo
		coreutils
  ];
  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToEscape = true;
  };
  fonts.packages = [(pkgs.nerdfonts.override {fonts = ["IosevkaTerm"];})];
  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;
  system.defaults = {
    # finder.AppleShowAllExtensions = true;
    # finder._FXShowPosixPathInTitle = true;
    dock.autohide = true;
    # NSGlobalDomain.AppleShowAllExtensions = true;
    NSGlobalDomain.InitialKeyRepeat = 14;
    NSGlobalDomain.KeyRepeat = 1;
  };
  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

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
}
