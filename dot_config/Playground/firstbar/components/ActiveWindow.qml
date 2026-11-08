import QtQuick
import Quickshell.Hyprland
import QtQuick.Layouts
import ".."
Text {
    text: Hyprland.activeToplevel?.title ?? ""
    elide: Text.ElideRight
    font: Config.sfont
    color: Config.fg
    Layout.maximumWidth: 400
}
