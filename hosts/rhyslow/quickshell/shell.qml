import qs.common
import Quickshell
import QtQuick
import QtQuick.Layouts

PanelWindow {
  id: root

  anchors {
    top: true
    left: true
    right: true
  }
  implicitHeight: 50

  color: Appearance.colors.bgLighter

  RowLayout {
    ActiveWindow {}
    Clock {}
  }
}
