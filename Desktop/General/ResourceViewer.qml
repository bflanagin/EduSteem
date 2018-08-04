import QtQuick 2.11
import QtQuick.Controls 2.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0


import "../theme"
import "../plugins"
import "../plugins/markdown.js" as Marks



ESborder {
    id:thisWindow
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter
    width:parent.width * 0.70
    height:cColumn.height+ 10

    property string media: ""
    property bool edit: false

   Column {
       id:cColumn
       width:parent.width * 0.99
       anchors.bottom:parent.bottom
       anchors.horizontalCenter: parent.horizontalCenter

    MarkDown {
        id:mediaView
        visible: if(media.split("![")[1] !== undefined) {true} else {false}
        enabled: visible
        width:parent.width
        thedata: media

    }

    Text {
        visible: if(mediaView.visible === true){false} else {true}
        enabled: visible
        text:media
    }

   }

    MouseArea {
        anchors.centerIn: parent
        width:mainView.width
        height:mainView.height
        onClicked: thisWindow.state = "inActive"
    }

}
