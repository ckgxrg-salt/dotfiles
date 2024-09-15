/*
 * The layout selection menu.
 */

const currentLayout = Variable(0);
var laptopCss = `
        background-color: rgba(86, 241, 255, 0.4);
        font-size: 48px;
        min-width: 96px;
        min-height: 96px;
    `;
var tabletCss = `
        background-color: rgba(42, 201, 249, 0.4);
        font-size: 48px;
        min-width: 96px;
        min-height: 96px;
    `;
var tentCss = `
        background-color: rgba(191, 75, 248, 0.4);
        font-size: 48px;
        min-width: 96px;
        min-height: 96px;
    `;
var bookCss = `
        background-color: rgba(211, 77, 238, 0.4);
        font-size: 48px;
        min-width: 96px;
        min-height: 96px;
    `;

function laptopButton() {
    return Widget.Button({
        child: Widget.Label(' '),
        css: laptopCss,
        onClicked: () => {
            Utils.exec(['systemctl', '--user', 'start', 'laptop.target']);
            laptopCss = 'color: aqua;';
            tabletCss = 'color: blue;';
            tentCss = 'color: blue;';
            bookCss = 'color: blue;';
            currentLayout.setValue(0);
        }
    });
};
function tabletButton() {
    return Widget.Button({
        child: Widget.Label('󰓶 '),
        css: tabletCss,
        onClicked: () => {
            Utils.exec(['systemctl', '--user', 'start', 'tablet.target']);
            laptopCss = 'color: blue;';
            tabletCss = 'color: aqua;';
            tentCss = 'color: blue;';
            bookCss = 'color: blue;';
            currentLayout.setValue(1);
        }
    });
};
function tentButton() {
    return Widget.Button({
        child: Widget.Label('󰔈 '),
        css: tentCss,
        onClicked: () => {
            Utils.exec(['systemctl', '--user', 'start', 'tent.target']);
            laptopCss = 'color: blue;';
            tabletCss = 'color: blue;';
            tentCss = 'color: aqua;';
            bookCss = 'color: blue;';
            currentLayout.setValue(2);
        }
    });
};
function bookButton() {
    return Widget.Button({
        child: Widget.Label(' '),
        css: bookCss,
        onClicked: () => {
            Utils.exec(['systemctl', '--user', 'start', 'book.target']);
            laptopCss = 'color: blue;';
            tabletCss = 'color: blue;';
            tentCss = 'color: blue;';
            bookCss = 'color: aqua;';
            currentLayout.setValue(3);
        }
    });
};

export function buttons() {
    return Widget.Box({
        spacing: 24,
        vertical: false,
        css: `
            background-color: rgba(68, 48, 97, 0.5);
            padding: 24px 24px 24px 24px;
            border-radius: 24px;
        `,
        children: [
            Widget.Box({
                spacing: 24,
                vertical: true,
                children: [
                    laptopButton(),
                    tabletButton()
                ]
            }),
            Widget.Box({
                spacing: 24,
                vertical: true,
                children: [
                    tentButton(),
                    bookButton()
                ]
            }),
        ]
    });
}