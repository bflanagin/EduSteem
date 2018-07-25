import QtQuick 2.11
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0

Rectangle {

    property string icon: "../icons/back.svg"
    property string fillcolor: "white"
    radius: width / 2
    color: seperatorColor

    Image {
        id: theicon
        visible: false
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: parent.width * -0.05
        source: icon
        width: parent.width * 0.7
        height: parent.width * 0.7
        fillMode: Image.PreserveAspectFit
        onSourceChanged: if(icon !== "../icons/back.svg") {anchors.horizontalCenterOffset = 0}
    }

    ColorOverlay {
        source: theicon
        anchors.fill: theicon
        color: fillcolor
    }
}
