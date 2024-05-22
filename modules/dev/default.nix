{ config, pkgs, ... }:
{
  # Gradle Build Tool
  programs.gradle = {
    enable = true;
    home = ".gradle";
  };

  # Rust toolchain and IDEs
  home.packages = with pkgs; [
    rust-bin.stable.latest.default
    gcc
    jdk21

    eclipses.eclipse-java
    jetbrains.rust-rover
  ];
}