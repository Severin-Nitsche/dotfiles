import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

import qs.state

WrapperRectangle {
  id: root

  property url menuIcon
  property string menuText
  
  enum Clear {
    Text,
    Icon
  }

  property int clear: isIcon ? BarMenu.Clear.Text : BarMenu.Clear.Icon

  // QML is dogshit
  property var isIcon: menuIcon != ""
  property var clearIcon: BarMenu.Clear.Icon == clear
  property bool showMenu: false

  color: showMenu ? GlobalState.barHighlight : 'transparent'

  default property list<QtObject> menuItems

  Layout.fillHeight: true

  WrapperMouseArea {
    id: mouseArea

    Layout.fillHeight: true
    Layout.fillWidth: true

    implicitHeight: parent.height
    //margin: parent.height / (clearIcon ? 6 : 4)
    leftMargin: parent.height / (clearIcon ? 3 : 2)
    rightMargin: parent.height / (clearIcon ? 3 : 2)

    onClicked: root.showMenu = !root.showMenu

    child: visualChild

    Loader {
      id: visualChild
      sourceComponent: {
        loader.active = true
        isIcon ? iconComponent : textComponent
      }
    }

    Component {
      id: iconComponent

      Image {
        source: menuIcon
        fillMode: Image.PreserveAspectFit
        cache: false
        sourceSize.width: -1
        sourceSize.height: root.height * (clearIcon ? 2/3 : 1/2)
      }
    }

    Component {
      id: textComponent

      Text {
        text: menuText
        color: GlobalState.barText

        font.pixelSize: 1.3 * root.height * (clearIcon ? 2/3 : 1/2)
        verticalAlignment: Text.AlignVCenter
        font.family: "route159"
      }
    }

    LazyLoader {
      id: loader
      loading: menuItems.length > 0

      PopupWindow {
        id: popup

        anchor.item: root
        anchor.rect.y: root.height
        visible: root.showMenu

        HyprlandFocusGrab {
          id: grab
          active: root.showMenu
          windows: [popup]
          onCleared: root.showMenu = false
        }

        data: menuItems
      }
    }
  }

}
