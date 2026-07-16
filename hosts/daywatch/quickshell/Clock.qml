import qs.common
import QtQuick
import QtQuick.Layouts
import Quickshell

RowLayout {
  id: root
  spacing: 24

  SystemClock {
    id: clock
    precision: SystemClock.Minutes
  }

  Text {
    color: Colors.fgDark
    font.pixelSize: 96
    text: Qt.formatDateTime(clock.date, "hh")
  }

  ColumnLayout {
    Text {
      Layout.alignment: Qt.AlignHCenter
      color: Colors.fgDark
      font.pixelSize: 32
      text: Qt.formatDateTime(clock.date, "ddd")
    }
    Text {
      Layout.alignment: Qt.AlignHCenter
      color: Colors.fgDark
      font.pixelSize: 24
      text: Qt.formatDateTime(clock.date, "MM/dd")
    }
  }

  Text {
    color: Colors.fgDark
    font.pixelSize: 96
    text: Qt.formatDateTime(clock.date, "mm")
  }
}
