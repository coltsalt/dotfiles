import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Mpris
import ".."

RowLayout {
    id: root
    property string mode: "spotify"
    readonly property var selectedPlayer: {
        const players = Mpris.players.values;
        if (mode === "spotify") {
            return players.find(player => player.identity.toLowerCase().includes("spotify") || player.dbusName.toLowerCase().includes("spotify")) ?? null;
        }
        // global mode
        const playing = players.find(player => player.isPlaying);
        if (playing)
            return playing;

        return players.find(player => player.trackTitle !== "") ?? null;
    }
    Module{
        visible: selectedPlayer !== null && selectedPlayer.trackTitle !== ""
    RowLayout {
        spacing: 3
        Row {
            spacing: 4
            Text {
                text: root.selectedPlayer ? (root.selectedPlayer.trackArtist || "Unknown artist") : ""
                color: Config.fg
                font: Config.sfont
                elide: Text.ElideRight
            }
            Text {
                text: "-"
                color: Config.fg
                font: Config.sfont
            }
            Text {
                id: isplayingplaying
                text: root.selectedPlayer ? (root.selectedPlayer.trackTitle || "Unknown track") : ""
                color: Config.accent
                font: Config.sfont
                elide: Text.ElideRight
                Layout.maximumWidth: 200
            }
        }
        Text {
            font: Config.ifont
            color: Config.fg
            text: "skip_previous"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (root.selectedPlayer && root.selectedPlayer.canGoPrevious)
                        root.selectedPlayer.previous();
                }
            }
        }
        Text {
            font: Config.ifont
            color: Config.fg
            text: root.selectedPlayer && root.selectedPlayer.isPlaying ? "pause" : "play_arrow"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (root.selectedPlayer && root.selectedPlayer.canTogglePlaying)
                        root.selectedPlayer.togglePlaying();
                }
            }
        }

        Text {
            font: Config.ifont
            color: Config.fg
            text: "skip_next"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (root.selectedPlayer && root.selectedPlayer.canGoNext)
                        root.selectedPlayer.next();
                }
            }
        }
    }
}
}