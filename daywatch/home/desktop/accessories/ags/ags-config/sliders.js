/*
 * Volume and brightness sliders on a panel.
 */

const audio = await Service.import('audio');
import brightness from './brightness-service.js';

function volume() {
    return Widget.Slider({
        setup: self => self.hook(audio.speaker, () => {
            self.value = audio.speaker.volume || 0
        }),
        vertical: true,
        inverted: true,
        draw_value: false,
        class_name: 'vol',
        onChange: ({ value }) => audio['speaker'].volume = value
    });
}

function light() {
    return Widget.Slider({
        setup: self => self.hook(brightness, () => {
            self.value = brightness.screen_value || 0
        }),
        vertical: true,
        inverted: true,
        draw_value: false,
        class_name: 'light',
        on_change: self => brightness.screen_value = self.value
    });
}

export function sliders() {
    return Widget.Box({
        spacing: 16,
        vertical: false,
        css: `
            padding-left: 72px;
        `,
        children: [
            volume(),
            light()
        ]
    });
}