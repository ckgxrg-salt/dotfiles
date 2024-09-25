{ pkgs, ... }:
# Options for WLogout
{
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
        label = "logout";
        action = "hyprctl dispatch exit";
        text = "End Session";
        keybind = "e";
      }
      {
        label = "lock";
        action = "pidof hyprlock || hyprlock --immediate";
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
            #shutdown {
              background-color: #bf616a;
              background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/shutdown.png"));
            }
            #lock:focus, #lock:active, #lock:hover,
            #logout:focus, #logout:active, #logout:hover,
            #shutdown:focus, #shutdown:active, #shutdown:hover {
      	      background-color: #3700B3;
      	      outline-style: none;
            }
    '';
  };
}
