import Quickshell
import Quickshell.Services.SystemTray
import QtQuick
import QtQuick.Layouts
import ".."

Module {
    id: root

    // PanelWindow reference for native context menus
    required property var panelWindow

    // Expansion settings
    property bool expanded: false
    property int collapsedCount: 1

    horizontalPadding: 10
    verticalPadding: 4

    // Size follows the visible icons
    implicitWidth: tray.implicitWidth + horizontalPadding * 2
    implicitHeight: 19 + verticalPadding * 2

    visible: SystemTray.items.values.length > 0
    Behavior on implicitWidth {
    NumberAnimation {
        duration: 250
        easing.type: Easing.OutCubic
    }
}

    Row {
        id: tray

        anchors.centerIn: parent
        spacing: 8

        Repeater {
            model: SystemTray.items

            delegate: Item {
                id: entry

                required property var modelData
                required property int index

                implicitWidth: 18
                implicitHeight: 20

                visible: root.expanded || index < root.collapsedCount

                Image {
                    anchors.centerIn: parent

                    width: 18
                    height: 18

                    source: entry.modelData.icon
                    sourceSize: Qt.size(36, 36)

                    fillMode: Image.PreserveAspectFit
                    smooth: true
                
                }

                MouseArea {
                    anchors.fill: parent

                    cursorShape: Qt.PointingHandCursor

                    acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton

                    onClicked: mouse => {
                        const item = entry.modelData;

                        if (mouse.button === Qt.LeftButton) {
                            if (item.onlyMenu)
                                openMenu();
                            else
                                item.activate();
                        } else if (mouse.button === Qt.MiddleButton) {
                            item.secondaryActivate();
                        } else if (mouse.button === Qt.RightButton) {
                            openMenu();
                        }
                    }

                    function openMenu() {
                        const item = entry.modelData;

                        if (!item.hasMenu)
                            return;
                        const pos = entry.mapToItem(root.panelWindow.contentItem, 0, entry.height);

                        item.display(root.panelWindow, pos.x, pos.y);
                    }

                    onWheel: wheel => {
                        entry.modelData.scroll(wheel.angleDelta.y, false);
                    }
                }
            }
        }

        // Expand / collapse arrow
        Item {
            id: expandButton

            visible: SystemTray.items.values.length > root.collapsedCount

            implicitWidth: visible ? 14 : 0
            implicitHeight: 20

            Text {
                anchors.centerIn: parent

                text: root.expanded ? "arrow_menu_open" : "arrow_menu_close"
            

                color: Config.fg
                font: Config.ifont
            }

            MouseArea {
                anchors.fill: parent

                cursorShape: Qt.PointingHandCursor

                onClicked: {
                    root.expanded = !root.expanded;
                }
            }
        }
    }

    Behavior on implicitWidth {
        NumberAnimation {
            duration: 200
            easing.type: Easing.OutCubic
        }
    }
}
