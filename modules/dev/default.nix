{ config, pkgs, ... }:
{
  # Gradle Build Tool
  programs.gradle = {
    enable = true;
    home = ".gradle";
  };
  programs.java = {
    enable = true;
  };

  # Rust toolchain and IDEs
  home.packages = with pkgs; [
    rust-bin.stable.latest.default
    gcc

    eclipses.eclipse-java
    jetbrains.rust-rover
  ];
}