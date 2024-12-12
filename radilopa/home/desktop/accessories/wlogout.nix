{ pkgs, ... }:
# Options for wlogout
{
  # Summon wlogout on lock event
  systemd.user.services."wlogout" =
    let
      summon-wlogout = pkgs.writeShellScript "summon-wlogout" ''
        hyprctl dispatch exec "canberra-gtk-play -i desktop-logout -d wlogout"
        hyprctl dispatch exec uwsm app -- wlogout
        systemctl --user start unlock.target
      '';
    in
    {
      Unit = {
        Description = "wlogout Logout Screen";
        Requires = [ "graphical-session.target" ];
      };
      Service = {
        Type = "oneshot";
        ExecStart = "${pkgs.bash}/bin/bash ${summon-wlogout}";
        Slice = "app-graphical.slice";
      };
      Install = {
        WantedBy = [ "lock.target" ];
      };
    };
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
        label = "suspend";
        action = "systemctl suspend";
        text = "Sleep";
        keybind = "p";
      }
      {
        label = "hibernate";
        action = "systemctl hibernate";
        text = "Hibernate";
        keybind = "h";
      }
      {
        label = "logout";
        action = "uwsm stop";
        text = "End Session";
        keybind = "e";
      }
      {
        label = "lock";
        action = "hyprlock --immediate";
        text = "Lock Screen";
        keybind = "l";
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
            #suspend {
              background-color: #b48ead;
              background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/suspend.png"));
            }
            #hibernate {
              background-color: #5e81ac;
              background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/hibernate.png"));
            }
            #shutdown {
              background-color: #bf616a;
              background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/shutdown.png"));
            }
            #reboot {
              background-color: #d08770;
              background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/reboot.png"));
            }
            #lock:focus, #lock:active, #lock:hover,
            #logout:focus, #logout:active, #logout:hover,
            #suspend:focus, #suspend:active, #suspend:hover,
            #hibernate:focus, #hibernate:active, #hibernate:hover,
            #shutdown:focus, #shutdown:active, #shutdown:hover,
            #reboot:focus, #reboot:active, #reboot:hover {
      	      background-color: #3700B3;
      	      outline-style: none;
            }
    '';
  };
}
