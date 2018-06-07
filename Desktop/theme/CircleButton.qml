import QtQuick 2.11
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0

Rectangle {


    radius:width /2
    color:seperatorColor

    Image {
        id:icon
        visible: false
        anchors.centerIn: parent
        source:"../icons/back.svg"
        width:parent.width * 0.7
        height:parent.width * 0.7
        fillMode: Image.PreserveAspectFit
    }

    ColorOverlay {
        source:icon
        anchors.fill: icon
        color:"white"
    }

}
