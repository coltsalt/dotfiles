import QtQuick
import Quickshell
import Quickshell.Wayland
import QtQuick.Layouts
import "components"

Variants {
    model: Quickshell.screens
    PanelWindow {
        id: root
        required property var modelData
        screen: modelData
        anchors {
            top: true
            left: true
            right: true
        }

        implicitHeight: 38
        color: "transparent"

        // margins {
        //     top: 0
        //     left: 150
        //     right: 150
        // }
        // change to BarRadius if rounded bar
        BarRadius {
            anchors.fill: parent
            RowLayout {
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 20
                spacing: 20
                // ActiveWindow {}
                MusicPlayer {}
            }
            RowLayout {
                id: centerGroup
                anchors.centerIn: parent
                spacing: 8
                Module {
                    Clock {}
                }
                Workspaces {
                    screen: root.modelData
                }
            }
            RowLayout {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.rightMargin: 20
                spacing: 20

                Weather {}

                Tray {
                    panelWindow: root
                }
            }
        }
    }
}
