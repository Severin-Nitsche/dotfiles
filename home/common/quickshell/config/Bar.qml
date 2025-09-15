import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets

Scope {
  id: bar
  Variants {
    model: Quickshell.screens
    PanelWindow {
      id: panel
      required property var modelData
      property int mm: Screen.pixelDensity
      screen: modelData
      implicitHeight: GlobalState.barHeight*mm
      color: 'red'
      anchors {
        top: true
	left: true
	right: true
      }
      RowLayout {
        id: container
	anchors.fill: parent
	RowLayout {
          id: left
          Layout.fillWidth: true
	  Layout.fillHeight: true
	  SystemMenu {
	    anchorWindow: panel
	  }
        }
        RowLayout {
          id: right
          Layout.fillWidth: true
	  Layout.fillHeight: true
	  layoutDirection: Qt.RightToLeft
	}
      }
    }
  }
}
