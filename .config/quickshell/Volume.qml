pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Widgets

Scope {
  id: root

  readonly property var audio: Pipewire.defaultAudioSink?.audio
  readonly property real volume: audio?.volume ?? 0
  readonly property bool muted: audio?.muted ?? false

  PwObjectTracker {
    objects: [Pipewire.defaultAudioSink]
  }

  Connections {
    target: root.audio

    function onVolumeChanged() {
      root.shouldShowOsd = true;
      hideTimer.restart();
    }

    function onMutedChanged() {
      root.shouldShowOsd = true;
      hideTimer.restart();
    }
  }

  property bool shouldShowOsd: false

  Timer {
    id: hideTimer
    interval: 1500
    onTriggered: root.shouldShowOsd = false
  }

  LazyLoader {
    active: root.shouldShowOsd

    PanelWindow {
      anchors.bottom: true
      margins.bottom: screen.height / 50
      exclusiveZone: 0

      implicitWidth: 280
      implicitHeight: 50
      color: "transparent"

      mask: Region {}

      Rectangle {
        anchors.fill: parent
        radius: height / 2
        color: "#80000000"

        RowLayout {
          anchors {
            fill: parent
            leftMargin: 10
            rightMargin: 15
          }

        IconImage {
            implicitSize: 30
            source: {
              if (root.muted || root.volume === 0)
                return Quickshell.iconPath("audio-volume-muted-symbolic");
              if (root.volume < 0.33)
                return Quickshell.iconPath("audio-volume-low-symbolic");
              if (root.volume < 0.66)
                return Quickshell.iconPath("audio-volume-medium-symbolic");
              return Quickshell.iconPath("audio-volume-high-symbolic");
            }
          }

          Rectangle {
            Layout.fillWidth: true

            implicitHeight: 10
            radius: 20
            color: "#50ffffff"

            Rectangle {
              anchors {
                left: parent.left
                top: parent.top
                bottom: parent.bottom
              }

              implicitWidth: parent.width * Math.min(root.volume, 1.0)
              radius: parent.radius
              color: root.muted ? "#50ffffff" : "#ffffffff"
            }
          }
        }
      }
    }
  }
}
