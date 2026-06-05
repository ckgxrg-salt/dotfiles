import qs.common
import QtQuick
import Quickshell

Item {
    id: root

    SystemClock {
      id: clock
      precision: SystemClock.Minutes
    }

    Text {
      color: Appearance.colors.fgDark
      font.pixelSize: 12
      text: Qt.formatDateTime(clock.date, "hh:mm")
    }
}
