import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets
import Quickshell.Hyprland

Scope {
  id: bar
  Variants {
    model: Quickshell.screens
    PanelWindow {
      id: panel

      required property var modelData
      screen: modelData

      property int mm: Screen.pixelDensity
      implicitHeight: GlobalState.barHeight*mm

      anchors {
        top: true
	left: true
	right: true
      }

      color: GlobalState.barBackground
      
      RowLayout {
        id: container
        anchors.fill: parent
        RowLayout {
          id: left
          Layout.fillHeight: true
          SystemMenu {}
        }
        Item { Layout.fillWidth: true }
        RowLayout {
          id: right
          Layout.fillHeight: true
          layoutDirection: Qt.RightToLeft
          Item {}
          Clock {}
        }
      }
    }
  }
}
