import QtQuick

import qs.bar
import qs.state

BarMenu {

  property bool showIcon: Screen.pixelDensity >= GlobalState.minLogomarkDensity

  menuIcon: showIcon ? GlobalState.logomark : GlobalState.logotype
  clear: showIcon ? BarMenu.Clear.Icon : BarMenu.Clear.Text

  Text {
    text: "MenuItem"
  }

}
