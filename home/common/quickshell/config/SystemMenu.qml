import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
WrapperRectangle { color: 'green'
  id: root
  property bool showIcon: Screen.pixelDensity > 4
  Layout.preferredWidth: showIcon ? parent.height : -1
  Layout.fillHeight: true
  required property QtObject anchorWindow
WrapperMouseArea {

  Layout.fillHeight: true
  Layout.fillWidth: true

  margin: showIcon ? parent.height / 6 : parent.height / 4

  onClicked: loader.item.visible = !loader.item.visible

  WrapperRectangle {
  color: 'yellow'
  Image {
    id: icon
    source: showIcon ? GlobalState.logomark : GlobalState.logotype
    fillMode: Image.PreserveAspectFit
    cache: false
    sourceSize.width: -1
    sourceSize.height: 2*root.height/3
  }
  }
  
  LazyLoader {
    id: loader
    loading: true

    PopupWindow {
      anchor.window: root.anchorWindow
      anchor.rect.y: root.anchorWindow.height
    }
  }
}}
