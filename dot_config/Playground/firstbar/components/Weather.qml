 import QtQuick
import QtQuick.Layouts
import ".."
Module {
verticalPadding: 3
RowLayout {
    id: root

    spacing: 6

    WeatherService {
        id: weather
    }

    readonly property string weatherIcon: {
        const c = weather.condition.toLowerCase()

        if (c.includes("thunder"))
            return "thunderstorm"
        if (c.includes("snow") || c.includes("sleet"))
            return "weather_snowy"
        if (c.includes("rain") || c.includes("drizzle"))
            return "rainy"
        if (c.includes("fog") || c.includes("mist"))
            return "foggy"
        if (c.includes("overcast"))
            return "cloud"
        if (c.includes("cloud"))
            return "partly_cloudy_day"
        if (c.includes("clear") || c.includes("sunny"))
            return "sunny"

        return "thermometer"
    }

    Text {
        text: root.weatherIcon
        font: Config.ifont
        color: Config.fg
    }

    Text {
        text: weather.temperature

        color: Config.fg
        font: Config.sfont
    }

    Text {
        text: weather.error !== ""
            ? weather.error
            : weather.condition

        color: Config.fg
        font: Config.sfont

        visible: weather.error !== "" || weather.condition !== ""
    }
}}