import Quickshell
import Quickshell.Widgets
import Quickshell.Io

import QtQuick
import QtQuick.Layouts

import qs.bar
import qs.state


BarMenu {
  id: root

  property bool showIcon: Screen.pixelDensity >= GlobalState.minLogomarkDensity

  menuIcon: showIcon ? GlobalState.logomark : GlobalState.logotype
  clear: showIcon ? BarMenu.Clear.Icon : BarMenu.Clear.Text

  MenuItem {
    implicitHeight: root.height
    menuText: "Ruhezustand"
    menuIcon: Quickshell.shellDir + "/icons/Charging.svg"

    Process {
      id: sleep

      command: ["systemctl", "suspend"]

      running: false
    }

    onClicked: sleep.running = true
  }
  MenuItem {
    implicitHeight: root.height
    menuText: "Abmelden"
    menuIcon: Quickshell.shellDir + "/icons/Charging.svg"

    Process {
      id: logout

      command: ["uwsm", "stop"]

      running: false
    }

    onClicked: logout.running = true
  }
  MenuItem {
    implicitHeight: root.height
    menuText: "Herunterfahren"
    menuIcon: GlobalState.power

    Process {
      id: shutdown

      command: ["shutdown", "now"]

      running: false
    }

    onClicked: shutdown.running = true
  }

}
