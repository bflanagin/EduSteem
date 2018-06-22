import QtQuick 2.11
import QtQuick.Controls 2.2

import "../theme"
import "../plugins"
import "../Educator"

import "../Educator/course.js" as Scripts
import "../plugins/text.js" as Scrubber

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

        Item {
            width:parent.width
            height:title.height

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

    Button {
        anchors.right: parent.right
        anchors.verticalCenter: title.verticalCenter
        text:"Add"
        background:ESTextField {

        }

        onClicked: {
            newQuestion.type = 1
            newQuestion.state = "Active"
        }
    }

    }

    Rectangle {

        width: parent.width * 0.99
        anchors.horizontalCenter: parent.horizontalCenter
        height: 3
        color: seperatorColor
    }
        ScrollView {
        id: view
         anchors.horizontalCenter: parent.horizontalCenter
         width:parent.width * 0.90
        height:switch(field) {
               case "Title": contentHeight + 10;break;
               default: 400;break;
               }
        background: ESTextField{}



        TextArea {

            id:changeBox
            anchors.fill: parent
            horizontalAlignment: Text.AlignLeft
            wrapMode: Text.WordWrap

            text:Scrubber.recoverSpecial(existing)
            padding: 5


        }

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
                    Scripts.editField(field,where,itemId,Scrubber.replaceSpecials(changeBox.text))
                }

                thisWindow.state = "inActive"
            }
        }
    }

    QuestionWizard {
        id:newQuestion
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width * 1.05
        state: "inActive"
    }
}
