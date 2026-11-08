
import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import ".."

Rectangle {
    id: root

    required property var screen

    height: 25
    implicitWidth: workspaces.implicitWidth + 10
    implicitHeight: 26

    radius: height / 2

    // Subtle workspace container background
    color: Qt.rgba(Config.fg.r, Config.fg.g, Config.fg.b, 0.12)

    Row {
        id: workspaces

        anchors.centerIn: parent
        spacing: 5

        Repeater {
            model: Hyprland.workspaces

            Rectangle {
                required property var modelData

                width: modelData.active ? 30 : 7
                height: modelData.active ? 17 : 7

                anchors.verticalCenter: parent.verticalCenter

                radius: height / 2

                visible: modelData.id > 0
                    && modelData.monitor !== null
                    && modelData.monitor.name === root.screen.name

                color: modelData.active ? Config.accent : Config.fg
                opacity: modelData.active ? 1.0 : 0.45

                Behavior on width {
                    NumberAnimation {
                        duration: 220
                        easing.type: Easing.OutCubic
                    }
                }


                Behavior on x {
                    NumberAnimation {
                        duration: 220
                        easing.type: Easing.OutCubic
                    }
                }

                Behavior on color {
                    ColorAnimation { duration: 180 }
                }

                Behavior on opacity {
                    NumberAnimation { duration: 180 }
                }

                Text {
                    anchors.centerIn: parent
                    text: modelData.id
                    color: Config.bg
                    font: Config.sfont

                    visible: modelData.active
                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor

                    onClicked: modelData.activate()
                }
            }
        }
    }
}
