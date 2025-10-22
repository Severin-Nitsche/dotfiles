import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Hyprland
import Quickshell.Widgets

import qs.state
import qs.widgets

Scope {
  id: root
  default property Component delegate

  Variants {
    model: Quickshell.screens

    PanelWindow {
      id: bar

      required property var modelData
 screen: modelData

      color: GlobalState.barBackground

      anchors {
        top: true
        left: true
        right: true
      }

      readonly property real mm: screen.physicalPixelDensity
      implicitHeight: 5*mm

      data: delegate.createObject(bar)
    }
  }
}
