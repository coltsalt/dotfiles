import QtQuick
import Quickshell
import ".."

Scope {
    id: root
    property string temperature: "--"
    property string condition: "Loading Weather..."
    property string error: ""

    function refresh() {
        const request = new XMLHttpRequest();

        const city = encodeURIComponent(Config.weatherCity);
        const units = Config.weatherUnits === "m" ? "m" : "u";
        const url = "https://wttr.in/" + city + "?format=j1&" + units;

        request.onreadystatechange = function () {
            if (request.readyState !== XMLHttpRequest.DONE)
                return;
            if (request.status !== 200) {
                root.error = "Weather Unavailable";
                return;
            }
            try {
                const data = JSON.parse(request.responseText);
                const current = data.current_condition[0];
                root.temperature = (Config.weatherUnits === "m" ? current.temp_C : current.temp_F) + "°";
                root.condition = current.weatherDesc[0].value;
                root.error = "";
            } catch (e) {
                root.error = "invalid weather response";
            }
        };
        request.open("GET", url);
        request.send();
    }
    Component.onCompleted: refresh()

    Timer {
        interval: 30 * 60 * 1000
        running: true
        repeat: true
        onTriggered: root.refresh()
    }
}
