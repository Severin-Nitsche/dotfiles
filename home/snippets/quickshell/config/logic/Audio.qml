pragma Singleton

import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Hyprland
import Quickshell.Widgets

import qs.state

Singleton {
  id: root

  readonly property bool muted: Pipewire.defaultAudioSink.audio.muted
  readonly property real volume: Pipewire.defaultAudioSink.audio.volume

  PwObjectTracker {
    objects: [Pipewire.defaultAudioSink]
  }

  function toggleMute(node) {
    if (node.audio) {
      node.audio.muted = !node.audio.muted
    }
  }

  function changeVolume(node, step) {
    if (node.audio) {
      let target = node.audio.volume + step
      if (target > GlobalState.maxAudio)
        target = GlobalState.maxAudio
      if (target < 0)
        target = 0
      node.audio.volume = target
    }
  }

  function defaultAction() {
    indicator.visible = true
    timer.stop()
    timer.start()
  }

  Timer {
    id: timer
    interval: 1500
    onTriggered: {
      indicator.visible = false
    }
  }

  PanelWindow {
    id: indicator
    visible: false
    color: GlobalState.transparentBarBackground

    WrapperRectangle {
      Layout.fillHeight: true
      Layout.fillWidth: true

      margin: parent.height / 6
      topMargin: parent.height / 12
      bottomMargin: parent.height / 12
      color: "transparent"

      ColumnLayout {
        Image {
          source: Audio.muted ?
            GlobalState.mute :
            GlobalState.volume
          fillMode: Image.PreserveAspectFit
          cache: false
          sourceSize.width: -1
          sourceSize.height: indicator.height * 2/3
        }

        WrapperRectangle {
          id: wrapper
          color: "transparent"
          implicitWidth: indicator.height * 2/3 * root.volume / GlobalState.maxAudio
          implicitHeight: indicator.height / 6
          Image {
            source: Quickshell.shellDir + '/icons/audio.png'
            fillMode: Image.TileHorizontally
            anchors.fill: parent
            cache: false
            sourceSize.width: -1
            sourceSize.height: indicator.height / 6
            horizontalAlignment: Image.AlignLeft
          }
        }
      }
    }
  }

  GlobalShortcut {
    name: "mute"
    description: "(Un)mute the audio"

    onPressed: {
      defaultAction()
      toggleMute(Pipewire.defaultAudioSink)
    }
  }

  GlobalShortcut {
    name: "volumeUp"
    description: "Raise the volume"

    onPressed: {
      defaultAction()
      changeVolume(
        Pipewire.defaultAudioSink,
        GlobalState.audioStep,
      )
    }
  }

  GlobalShortcut {
    name: "volumeDown"
    description: "Lower the volume"

    onPressed: {
      defaultAction()
      changeVolume(
        Pipewire.defaultAudioSink,
        -GlobalState.audioStep,
      )
    }
  }
}
