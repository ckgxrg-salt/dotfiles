{ pkgs, ... }:
# Options for WLogout
{
  # Summon wlogout on lock event
  systemd.user.services."wlogout" = {
    Unit = {
      Description = "wlogout Logout Screen";
      Requires = [
        "graphical-session.target"
        "lock.target"
      ];
      Conflicts = [
        "unlock.target"
        "sleep.target"
      ];
    };
    Service = {
      Type = "exec";
      ExecStart = "${pkgs.wlogout}/bin/wlogout";
      ExecStartPost = "${pkgs.libcanberra-gtk3}/bin/canberra-gtk-play -i desktop-logout -d wlogout";
      ExecStopPost = "${pkgs.systemd}/bin/systemctl --user start unlock.target";
      Slice = "app-graphical.slice";
    };
    Install = {
      WantedBy = [ "lock.target" ];
    };
  };

  # Wlogout the Logout Menu
  programs.wlogout = {
    enable = true;
    layout = [
      {
        label = "shutdown";
        action = "systemctl poweroff";
        text = "Shutdown";
        keybind = "s";
      }
      {
        label = "reboot";
        action = "systemctl reboot";
        text = "Reboot";
        keybind = "r";
      }
      {
        label = "logout";
        action = "uwsm stop";
        text = "End Session";
        keybind = "e";
      }
      {
        label = "lock";
        action = "pidof hyprlock || hyprlock --immediate";
        text = "Lock Screen";
        keybind = "l";
      }
      {
        label = "suspend";
        action = "systemctl suspend-then-hibernate";
        text = "Take a Nap";
        keybind = "n";
      }
      {
        label = "hibernate";
        action = "systemctl hibernate";
        text = "Deep Sleep";
        keybind = "h";
      }
    ];
    style = ''
            * {
      	      background-image: none;
      	      box-shadow: none;
            }
            button {
              border-radius: 60px;
              border-color: #d8dee9;
      	      text-decoration-color: #FFFFFF;
              color: #FFFFFF;
      	      border-style: solid;
      	      border-width: 5px;
      	      background-repeat: no-repeat;
      	      background-position: center;
      	      background-size: 25%;
            }
            #lock {
              background-color: #a3be8c;
              background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/lock.png"));
            }
            #logout {
              background-color: #ebcb8b;
              background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/logout.png"));
            }
            #shutdown {
              background-color: #bf616a;
              background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/shutdown.png"));
            }
            #suspend {
              background-color: #a3be8c;
              background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/suspend.png"));
            }
            #hibernate {
              background-color: #ebcb8b;
              background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/hibernate.png"));
            }
            #reboot {
              background-color: #bf616a;
              background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/reboot.png"));
            }
            #lock:hover,#logout:hover,#shutdown:hover,#suspend:hover,#hibernate:hover,#reboot:hover {
      	      background-color: #3700B3;
      	      outline-style: none;
            }
    '';
  };
}
