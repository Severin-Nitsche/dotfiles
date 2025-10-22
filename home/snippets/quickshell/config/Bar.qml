import QtQuick
import QtQuick.Layouts

import qs.bar
import qs.state
import qs.widgets

BarWindow {

  Bar {
    Left {
      SystemMenu {}
    }
    Item { Layout.fillWidth: true }
    Right {
      Clock {}
    }
  }

}
