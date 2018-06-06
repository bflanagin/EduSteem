import QtQuick 2.11
import QtQuick.Controls 2.2

import "./theme"
import "./plugins"

import "./course.js" as Scripts

ESborder {
    id: thisWindow
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter
    height: cColumn.height + 50 + buttonRow.height

    property string field: ""
    property string where: ""
    property real itemId: 0
    property string existing: ""

    onStateChanged: if(state == "Active") {existing =Scripts.pullField(field,where,itemId)} else { }

    Column {
        id:cColumn
        width:parent.width * 0.95
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: thisWindow.width * 0.02

    Text {
        id: title
        anchors.horizontalCenter: parent.horizontalCenter
        text: switch(field) {
              case "gq":"Guiding Questions";break;
              case "rq":"Review Questions";break;
              default:field;break;

              }

        font.pointSize: 18
    }

    Rectangle {

        width: parent.width * 0.99
        anchors.horizontalCenter: parent.horizontalCenter
        height: 3
        color: seperatorColor
    }

        TextArea {
            anchors.horizontalCenter: parent.horizontalCenter
            id:changeBox
            width:parent.width * 0.90
            height:switch(field) {
                   case "Title": contentHeight + 10;break;
                   default: 400;break;
                   }

            wrapMode: Text.WordWrap
            background: ESTextField{}
            text:existing
            padding: 5


        }
    }


    Row {
        id: buttonRow
        anchors.bottomMargin: 10
        anchors.bottom: parent.bottom
        width: parent.width * 0.98
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: parent.width * 0.39

        Button {

            width: parent.width * 0.30
            background: ESTextField {
            }

            text: qsTr("Cancel")

            onClicked: {
                thisWindow.state = "inActive"
            }
        }

        Button {

            width: parent.width * 0.30
            background: ESTextField {
            }
            text: qsTr("Okay")

            onClicked: {

                if(field =="Title") {
                    Scripts.editField(field,where,itemId,changeBox.text.replace(/ /g,"_").trim())
                } else {
                    Scripts.editField(field,where,itemId,changeBox.text)
                }

                thisWindow.state = "inActive"
            }
        }
    }
}
