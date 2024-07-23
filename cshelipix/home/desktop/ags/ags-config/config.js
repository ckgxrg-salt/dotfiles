/*
 * Main entry of the AGS configuration.
 */

import { buttons } from "./layout-panel.js";
import { shortcuts } from "./hyprland-actions.js";
import { sliders } from "./sliders.js";

function Bar(monitor = 0) {
    return Widget.Window({
        monitor,
        name: `bar${monitor}`,
        css: 'background-color: transparent;',
        layer: 'overlay',
        anchor: ['top', 'right'],
        child: Widget.CenterBox({
            spacing: 16,
            vertical: false,
            css: `
                background-color: transparent;
                padding: 24px 24px 24px 24px;
            `,
            startWidget: null,
            centerWidget: shortcuts(),
            endWidget: Widget.Box({
                spacing: 16,
                vertical: true,
                children: [
                    buttons(),
                    sliders()
                ]
            })
        })
    });
}

App.config({
    style: './style.css',
    windows: [
        Bar(0),
    ],
});