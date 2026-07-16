import qs.common
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Io
import Quickshell.Services.UPower

ColumnLayout {
  id: root
  spacing: 24

  RowLayout {
    id: power

    Button {
      icon.name: UPower.displayDevice.iconName
      text: (UPower.displayDevice.percentage * 100).toFixed(0) + "%"
    }

    ProgressBar {
      id: powerBar
      value: UPower.displayDevice.percentage

      background: Rectangle {
        implicitWidth: 200
        implicitHeight: 14

        color: Colors.bg
      }
      contentItem: Item {
        implicitWidth: 200
        implicitHeight: 10

        Rectangle {
          width: powerBar.visualPosition * parent.width
          height: parent.height
          color: Colors.green
        }
      }
    }
  }

  function updateCpuMem() {
    cpuFile.reload()
    let values = cpuFile.text().split('\n')[0].trim().split(/\s+/)
    let idle = parseInt(values[4])
    let total = parseInt(values[1]) + parseInt(values[2]) + parseInt(values[3]) + idle
    let idleDelta = idle - cpu.prevIdle
    let totalDelta = total - cpu.prevTotal

    cpu.percentage = 1.0 - (idleDelta / totalDelta)
    cpu.prevIdle = idle
    cpu.prevTotal = total

    memFile.reload()
    values = memFile.text().split('\n')
    let memTotal = values[0].split(/\s+/)[1]
    let memAvailable = values[2].split(/\s+/)[1]

    mem.percentage = (memTotal - memAvailable) / memTotal
  }

  FileView {
    id: cpuFile
    path: "/proc/stat"
  }

  FileView {
    id: memFile
    path: "/proc/meminfo"
  }

  Timer {
    id: timer
    interval: 1000
    running: true
    repeat: true
    onTriggered: root.updateCpuMem()
  }

  RowLayout {
    id: cpu

    property real prevTotal: 0
    property real prevIdle: 0
    property real percentage: 0

    Button {
      icon.name: "cpu"
      text: (parent.percentage * 100).toFixed(0) + "%"
    }

    ProgressBar {
      id: cpuBar

      value: parent.percentage

      background: Rectangle {
        implicitWidth: 200
        implicitHeight: 14

        color: Colors.bg
      }
      contentItem: Item {
        implicitWidth: 200
        implicitHeight: 10

        Rectangle {
          width: cpuBar.visualPosition * parent.width
          height: parent.height
          color: Colors.cyan
        }
      }
    }
  }

  RowLayout {
    id: mem

    property real percentage: 0

    Button {
      icon.name: "drive-virtual"
      text: (parent.percentage * 100).toFixed(0) + "%"
    }

    ProgressBar {
      id: memBar

      value: parent.percentage

      background: Rectangle {
        implicitWidth: 200
        implicitHeight: 14

        color: Colors.bg
      }
      contentItem: Item {
        implicitWidth: 200
        implicitHeight: 10

        Rectangle {
          width: memBar.visualPosition * parent.width
          height: parent.height
          color: Colors.yellow
        }
      }
    }
  }
}
