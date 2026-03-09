import Quickshell
import QtQuick

Scope {
  id: root

  SystemClock {
    id: clock
    precision: SystemClock.Seconds
  }

  Variants {
    model: Quickshell.screens

    PanelWindow {
      required property var modelData
      screen: modelData

      anchors {
        top: true
        left: true
        right: true
      }

      implicitHeight: 30

      Text {
        anchors.centerIn: parent
        text: Qt.formatDateTime(clock.date, "hh:mm:ss")

      }
    }
  }
}
