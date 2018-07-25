import QtQuick 2.11
import QtQuick.Controls 2.2
import "../theme"
import "../plugins"
import "../General"

Row {
    property string thedata:""
    property string type:thedata.split("::")[0]
    property string title:thedata.split("::")[1]
    property string instructions:thedata.split("::")[2]

    spacing: parent.width * 0.025

    Image {
        width:parent.height * 0.8
        height:parent.height * 0.8
        source: switch(type) {
                case "Video": "/icons/videos"
                            break
                case "Web": "/icons/network"
                            break
                case "Journal": "/icons/documents"
                            break
                case "Writing": "/icons/documents"
                            break
                case "Reading": "/icons/bookmark"
                            break
                default: "/icons/edit-text.svg"


                }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.bottom
            text:title
            font.bold: true

        }

    }

    Rectangle {
        height:parent.height
        width:2
        color:seperatorColor
    }
    Column {
        height:parent.height
         width:parent.width * 0.65
     Text {
         text:qsTr("Instructions:")
         font.bold: true
     }

    Text {
        text:instructions
        wrapMode: Text.WordWrap
        maximumLineCount: 2
        width:parent.width

    }

    }


}
