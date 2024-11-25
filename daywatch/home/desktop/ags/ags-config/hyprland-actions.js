/*
 * The panel with a few useful shortcuts.
 */

const hyprland = await Service.import('hyprland');

function close() {
    return Widget.Button({
        child: Widget.Label('󰧼  Window Killer Mode'),
        css: `
            background-color: rgba(254, 57, 164, 0.4);
            font-size: 24px;
        `,
        onClicked: () => {
            if(hyprland.active.client.address == '0x') {
                hyprland.message('dispatch togglespecialworkspace controlcentre');
            }
            App.closeWindow("bar0");
            hyprland.message('kill');
            Utils.exec('notify-send -a "Control Centre" -i system-upgrade "Control Centre" "Who do you want to kill? =)"');
        }
    });
}

function fullscreen() {
    return Widget.Button({
        child: Widget.Label('  Toggle Fullscreen'),
        css: `
            background-color: rgba(255, 253, 187, 0.4);
            font-size: 24px;
        `,
        onClicked: () => {
            if(hyprland.active.client.address == '0x') {
                hyprland.message('dispatch togglespecialworkspace controlcentre');
            }
            App.closeWindow("bar0");
            hyprland.message('dispatch fullscreen');
            Utils.exec('notify-send -a "Control Centre" -i system-upgrade "Control Centre" "Toggled Fullscreen"');
        }
    });
}

function monitor() {
    return Widget.Button({
        child: Widget.Label('󰍺  Change Monitor'),
        css: `
            background-color: rgba(83, 232, 212, 0.4);
            font-size: 24px;
        `,
        onClicked: () => {
            App.closeWindow("bar0");
            if(hyprland.active.client.address == '0x') {
                hyprland.message('dispatch togglespecialworkspace controlcentre');
            }
            if (hyprland.active.monitor.name == 'eDP-1') {
                hyprland.message('dispatch focusmonitor eDP-2');
            } else {
                hyprland.message('dispatch focusmonitor eDP-1');
            }
            Utils.exec('notify-send -a "Control Centre" -i system-upgrade "Control Centre" "Whoosh!"');
        }
    })
}

export function shortcuts() {
    return Widget.Box({
        spacing: 16,
        vertical: true,
        css: `
            padding-top: 48px;
        `,
        children: [
            close(),
            fullscreen(),
            monitor()
        ]
    });
}