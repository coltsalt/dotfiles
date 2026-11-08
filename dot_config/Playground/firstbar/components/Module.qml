import QtQuick
import ".."

Rectangle {
    id: root
    visible: text !== ""
    // Allows other QML elements to be placed inside
    default property alias content: content.data

    // Appearance
    property color backgroundColor: Qt.rgba(Config.fg.r, Config.fg.g, Config.fg.b, 0.12)

    property real horizontalPadding: 10
    property real verticalPadding: 4

    radius: height / 2
    color: backgroundColor

    // Automatically size around the contents
    implicitWidth: content.childrenRect.width + horizontalPadding * 2

    implicitHeight: content.childrenRect.height + verticalPadding * 2

    // Inner content area
    Item {
        id: content

        anchors.fill: parent
        anchors.leftMargin: root.horizontalPadding
        anchors.rightMargin: root.horizontalPadding
        anchors.topMargin: root.verticalPadding
        anchors.bottomMargin: root.verticalPadding
    }
}
