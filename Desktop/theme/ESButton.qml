import QtQuick 2.11
import QtGraphicalEffects 1.0


Item {
    id:thisWindow

    property string label: ""
    property string icon: ""
    property string fillcolor: color1
    property bool entered:false


    clip:true


    Rectangle {
        id:highlight
        anchors.fill: parent
        opacity: 0.1
        visible: entered
    }

Column {
    anchors.centerIn: parent
    width:parent.width
    spacing: 3

   /* Rectangle {
        width: parent.width
        color: highLightColor1
        height: 1
    } */

    Item {
        width:if(label === "") {thisWindow.height} else {thisWindow.height * 0.4}
        height:width
        anchors.horizontalCenter: parent.horizontalCenter
    Image {
        id:iconImage
        width: parent.height
        height: parent.height
        anchors.horizontalCenter: parent.horizontalCenter
        source: icon
        visible: false
        fillMode: Image.PreserveAspectFit
    }

    ColorOverlay {
        anchors.fill: iconImage
        source: iconImage
        color:fillcolor
    }

    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        horizontalAlignment: Text.AlignHCenter
        wrapMode: Text.WordWrap
        text: label
        font.bold: true
        width: parent.width * 0.70
        color:fillcolor
        font.pixelSize: parent.width * 0.18
        visible: if(label === "") {false} else {true}
    }

   /* Rectangle {
        width: parent.width
        color: highLightColor1
        height: 1
    } */

}

MouseArea {
    anchors.fill: parent
    hoverEnabled: true
    onEntered:highlight.visible = true
    onExited: highlight.visible = false

}

}
