import Quickshell

import qs.bar
import qs.state
import qs.logic

BarMenu {
  menuIcon: Audio.muted ?
    GlobalState.mute :
    GlobalState.volume
}
