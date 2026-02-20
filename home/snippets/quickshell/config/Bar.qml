import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Services.UPower
import Quickshell.Services.Pipewire
import Quickshell.Hyprland

import qs.bar
import qs.state
import qs.widgets

BarWindow {

  Bar {
    Left {
      SystemMenu {}
    }
    Item { Layout.fillWidth: true }
    Left {
      Audio {}
      BarMenu {
        menuIcon: UPower.displayDevice.state == UPowerDeviceState.Charging ? Quickshell.shellDir+"/icons/Charging.svg" : ""
      }
      BarMenu {
        menuText: Math.round(UPower.displayDevice.percentage*100)+"%"
      }
      Clock {}
    }
  }

}
