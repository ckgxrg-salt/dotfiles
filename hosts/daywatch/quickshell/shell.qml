import qs.common
import Quickshell
import QtQuick
import QtQuick.Layouts

PanelWindow {
  id: root

  implicitHeight: 1024
  implicitWidth: 2048
  color: Appearance.colors.bgLighter

  ColumnLayout {
    RowLayout {
      Stats {}
      Clock {}
    }
    Fortune {}
  }
}
