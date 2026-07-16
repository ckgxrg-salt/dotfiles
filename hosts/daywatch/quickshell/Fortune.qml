import qs.common
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Io

RowLayout {
  id: root
  spacing: 24

  Process {
    id: update
    command: ["fortune"]
    running: true
    stdout: StdioCollector {
      onStreamFinished: quote.text = this.text
    }
  }

  Button {
    flat: true
    font.pixelSize: 14
    text: ""
    onClicked: update.running = true
  }

  Text {
    id: quote
    color: Colors.fgDark
    font.pixelSize: 24
    maximumLineCount: 4
    Layout.maximumWidth: 1024
    elide: Text.ElideRight
    wrapMode: Text.WordWrap

    HoverHandler {
      id: hover
    }

    ToolTip.visible: hover.hovered
    ToolTip.delay: 500
    ToolTip.text: this.text
  }
}
