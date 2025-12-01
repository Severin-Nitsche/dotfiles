import Quickshell
import Quickshell.Widgets

import QtQuick
import QtQuick.Layouts

import qs.bar
import qs.state

WrapperMouseArea {
  id: root

  property url menuIcon
  property string menuText

  leftMargin: root.height / 3
  rightMargin: root.height / 2

  RowLayout {
    Image {
      source: menuIcon
      fillMode: Image.PreserveAspectFit
      cache: false
      sourceSize.width: -1
      sourceSize.height: root.height * 2 / 3
    }
    Text {
      text: menuText
      color: GlobalState.barText
      font.pixelSize: 1.3 * root.height / 2
    }
  }
}
