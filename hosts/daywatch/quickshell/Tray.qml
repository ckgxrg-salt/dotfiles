import qs.common
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.SystemTray

RowLayout {
  id: root
  spacing: 16

  Repeater {
    model: SystemTray.items

    MenuButton {

    }
  }
}
