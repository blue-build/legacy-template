import QtQuick 2.9
import QtGraphicalEffects 1.9

Rectangle {
    id: root
    color: "#000000"

    AnimatedImage {
        id: loader
        source: "loader.gif"
        anchors.horizontalCenter: parent.horizontalCenter
        y: 0.9 * parent.height - height
    }

    Colorize {
        anchors.fill: loader
        source: loader
        hue: 0.8333333333333334
        saturation: 1
        lightness: -0.5
    }
}
