import qs.common
import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

Item {
    id: root
    property var activeWindow: Hyprland.activeToplevel

    ColumnLayout {
        Text {
            color: Appearance.colors.fgDark
            font.pixelSize: 12
            text: root.activeWindow?.title
        }

        Text {
            color: Appearance.colors.fgDark
            font.pixelSize: 10
            text: root.activeWindow?.address
        }
    }
}
