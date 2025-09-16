import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
WrapperRectangle { 
  id: root
  color: 'transparent'
  property bool showIcon: Screen.pixelDensity >= GlobalState.minLogomarkDensity
  Layout.preferredWidth: showIcon ? parent.height : -1
  Layout.fillHeight: true
  WrapperMouseArea {
  
    Layout.fillHeight: true
    Layout.fillWidth: true
  
    margin: showIcon ? parent.height / 6 : parent.height / 4
  
    onClicked: {
      loader.item.visible = !loader.item.visible
      if (loader.item.visible) {
        root.color = GlobalState.barHighlight
      } else {
        root.color = 'transparent'
      }
    }
  
    Image {
      id: icon
      source: showIcon ? GlobalState.logomark : GlobalState.logotype
      fillMode: Image.PreserveAspectFit
      cache: false
      sourceSize.width: -1
      sourceSize.height: 2*root.height/3
    }
    
    LazyLoader {
      id: loader
      loading: true
  
      PopupWindow {
	anchor.item: root
	anchor.rect.y: root.height
      }
    }
  }
}
