pragma Singleton
import QtQuick

QtObject {

    // COLORS
    readonly property color bg: '#111522'
    readonly property color bg2: "#1E263B"
    readonly property color fg: "#DCE3Ef"
    readonly property color accent: "#98A9C4"

    // FONTS
    readonly property font hfont: Qt.font({
        family: "Rubik",
        pointSize: 11,
        weight: 550
    })
    readonly property font sfont: Qt.font({
        family: "JetBrains Mono NerdFont",
        pointSize: 10,
        weight: 800
    })
    readonly property font ifont: Qt.font({
        family: "Material Symbols Rounded",
        pointSize: 13
    })
    // WEATHER 
    readonly property string weatherCity: "north_ogden"
    readonly property string weatherUnits: "u"
}
