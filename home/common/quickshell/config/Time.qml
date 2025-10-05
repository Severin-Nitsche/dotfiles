pragma Singleton

import Quickshell
import QtQml
import QtCore

Singleton {
  id: root

  readonly property string time: {
    Qt.formatDateTime(clock.date, Qt.DefaultLocaleShortDate)
  }

  SystemClock {
    id: clock
    precision: SystemClock.Minutes
  }
}
