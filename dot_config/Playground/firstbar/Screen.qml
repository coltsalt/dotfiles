import Quickshell
import QtQuick
import Quickshell.Wayland
import "components"

Scope {
    id: root
    property int thickness: 12

    Variants{
        model: Quickshell.screens
        Item{
            id: screenRoot
            required property var modelData

            PanelWindow{
                screen: screenRoot.modelData
                anchors {top: true; left: true; right: true}
                implicitWidth: root.thickness
                exclusiveZone: root.thickness
                WlrLayershell.layer: WlrLayer.bottom
                WlrLayershell.namespace: "quickshell-border-top"
                color: Config.bg
            }
            PanelWindow{
                screen: screenRoot.modelData
                anchors {bottom: true; right: true; left: true}
                implicitWidth: root.thickness
                exclusiveZone: root.thickness
                WlrLayershell.layer: WlrLayer.bottom
                WlrLayershell.namespace: "quickshell-border-bottom"
                color: Config.bg
            }
            PanelWindow{
                screen: screenRoot.modelData
                anchors {top: true; bottom: true; left: true}
                implicitWidth: root.thickness
                exclusiveZone: root.thickness
                WlrLayershell.layer: WlrLayer.bottom
                WlrLayershell.namespace: "quickshell-border-left"
                color: Config.bg
            }
            PanelWindow{
                screen: screenRoot.modelData
                anchors {top: true; bottom: true; right: true}
                implicitWidth: root.thickness
                exclusiveZone: root.thickness
                WlrLayershell.layer: WlrLayer.bottom
                WlrLayershell.namespace: "quickshell-border-right"
                color: Config.bg
            }
        }
    }
}