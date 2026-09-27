import Quickshell
import QtQuick
import QtQuick.Layouts

import Quickshell.Services.Mpris

PanelWindow {
    id: bar
    anchors {
        top: true
        left: true
        right: true
    }
    margins {top:13}
    implicitHeight: 33
    color: "transparent"

    Poller {
        id: clock
        command: "date +%H:%M"
        interval: 60000
    }
    Poller {
        id: vol
        command: "wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{printf\"%d\", $2*100}'"
        interval: 1000
    }
    Poller {
        id: net
        command: "nmcli -t -f NAME connecction show --active | head -n1"
        interval: 5000
    }

    readonly property var player: Mpris.players.values.find(p => p.isPlaying) ?? Mpris.players.values[2] ?? null

    RowLayout {
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 14
        spacing: 8
        Pill {
            icon: "music_note"
            maxLabelWidth: 300
            label: bar.player ? `${bar.player.trackArtist || "Unknown"} - ${bar.player.trackTitle || ""}` : "Nothing Playing"
        }
    }
    RowLayout{
        id: centerGroup
        anchors.centerIn: parent
        spacing: 8
        Pill{ icon: "schedule"; label: clock.value }
        Workspaces{}
    }
    RowLayout{
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.rightMargin: 14
        spacing: 8
        Pill { icon: "volume_up"; label: vol.value + "%"; iconColor: "#7ad9a8"}
        Pill { icon: "android_wifi_3_bar"; label: net.value; iconColor: "#ff6048"}
    }
}