import QtQuick 2.11
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0

Rectangle {
    property string label: ""
    property string fillcolor: "white"
    color: seperatorColor
    width:info.height
    height:info.width

    Text {
        id:info
        rotation: -90
        text: label
        padding:10
        color:fillcolor
        anchors.centerIn: parent
    }

}
