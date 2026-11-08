import QtQuick
import QtQuick.Controls
import ".."

Text {
    id: root

    property date currentDate: new Date()

    text: Qt.formatDateTime(currentDate, "h:mm AP")

    color: Config.fg
    font: Config.hfont

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            root.currentDate = new Date();
        }
    }
}
