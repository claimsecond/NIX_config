{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "nixos";
  time.timeZone = "Europe/Kyiv";

  users.users.claim = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  services.xserver = {
    enable = true;
    layout = "us,ru,ua";
    xkbOptions = "grp:alt_shift_toggle";
    windowManager.i3.enable = true;
  };

  environment.systemPackages = with pkgs; [
    wget
    git
    kitty
    btop
    ncdu
    google-chrome
    ripgrep
  ];

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "25.05";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
}
