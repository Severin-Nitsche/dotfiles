import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Hyprland
import Quickshell.Widgets

import qs.state
import qs.widgets
import qs.logic

Scope {
  id: root
  default property Component delegate

  Variants {
    model: Quickshell.screens

    PanelWindow {
      id: bar

      visible: !BOSD.active

      required property var modelData
      screen: modelData

      color: GlobalState.barBackground

      anchors {
        top: true
        left: true
        right: true
      }

      readonly property real mm: screen.physicalPixelDensity
      readonly property int refSize: screen.width < screen.height ?
        screen.width : screen.height

      implicitHeight: Math.round(GlobalState.barHeight*refSize)

      data: delegate.createObject(bar)
    }
  }
}
