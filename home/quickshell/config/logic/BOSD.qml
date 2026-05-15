pragma Singleton

import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Hyprland
import Quickshell.Widgets

import qs.state

Singleton {
  id: root

  property bool active: false

  function defaultAction() {
    active = true
    timer.stop()
    timer.start()
  }

  Timer {
    id: timer
    interval: 3000
    onTriggered: {
      active = false
    }
  }

  PanelWindow {
    id: bosd
    color: "#0475d8"

    visible: active

    anchors {
      left: true
      bottom: true
      right: true
      top: true
    }

    WrapperRectangle {
      Layout.fillHeight: true
      Layout.fillWidth: true

      color: "transparent"

      Column {
        spacing: bosd.height / 30
        topPadding: bosd.height / 5
        leftPadding: bosd.height / 5

        Text {
          text: ":("
          font.family: "FreeSans"
          color: "white"
          font.pixelSize: bosd.height / 5
        }
        Text {
          text: "You're PC ran into a problem and needs to restart. We're\n" +
          "just collecting some error info, and then we'll restart for\n" +
          "you."
          font.family: "FreeSans"
          color: "white"
          font.pixelSize: bosd.height / 30
        }
        Text {
          text: "69% complete"
          font.family: "FreeSans"
          color: "white"
          font.pixelSize: bosd.height / 30
        }
        Text {
          text: "For more information about this issue and possible fixes, visit our website."
          font.family: "FreeSans"
          color: "white"
          font.pixelSize: bosd.height / 60
        }
        Text {
          text: "If you call a support person, give them this info:\n\n" +
          "Stop code: 0x06900420"
          font.family: "FreeSans"
          color: "white"
          font.pixelSize: bosd.height / 60
        }
      }
    }

  }

  GlobalShortcut {
    name: "BOSD"
    description: "Display the Blue Screen of Death"

    onPressed: {
      defaultAction()
    }
  }
}
