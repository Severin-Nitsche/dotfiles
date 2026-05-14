import Quickshell
import Quickshell.Widgets

import QtQuick
import QtQuick.Layouts

import qs.bar
import qs.state

WrapperMouseArea {
  id: root

  Layout.fillWidth: true

  property url menuIcon
  property string menuText

  hoverEnabled: true

  WrapperRectangle {
    leftMargin: root.height / 3
    rightMargin: root.height / 2

    color: root.containsMouse ? GlobalState.palette[2] : "transparent"
    Row {
      spacing: root.height / 3
      topPadding: root.height / 6

      Image {
        id: icon
        source: menuIcon
        fillMode: Image.PreserveAspectFit
        cache: false
        sourceSize.width: -1
        sourceSize.height: root.height * 2 / 3
      }
      Text {
        anchors.verticalCenter: icon.verticalCenter
        text: menuText
        color: GlobalState.barText
        font.pixelSize: 1.3 * root.height / 2
      }
    }
  }
}
