import QtQuick
import QtQuick.Layouts

import Quickshell.Services.UPower

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
      BarMenu {
        menuText: Math.round(UPower.displayDevice.percentage*100)+"%"
      }
      Clock {}
    }
  }

}
