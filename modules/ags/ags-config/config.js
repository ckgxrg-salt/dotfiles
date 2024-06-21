/*
 * Main entry of the AGS configuration.
*/

const testLabel = Widgets.Label({
    label: 'Good morning my neighbours!',
})

const testBar = Widgets.Window({
    name: 'test',
    anchor: ['top', 'left', 'right'],
    child: testLabel,
})

App.config({
    windows: [testBar]
});