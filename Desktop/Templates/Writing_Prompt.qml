import QtQuick 2.11
import QtQuick.Controls 2.2
import "../theme"
import "../plugins"
import "../General"

import "../plugins/text.js" as Scrubber

Item {
    id: thisWindow
    width: parent.width * 0.98
    height: parent.height * 0.98

    ESborder {
        id:promptBlock
        anchors.left:parent.left
        anchors.top:parent.top
        width:parent.width * 0.24
        height:parent.height * 0.50

        Text {
            id: prompttitle
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.margins: 10
            font.bold: true
            font.pointSize: 12
            text: qsTr("Prompt")
        }

        Rectangle {
            anchors.top: prompttitle.bottom
            width: parent.width * 0.98
            anchors.horizontalCenter: parent.horizontalCenter
            height: 3
            color: seperatorColor
        }

        ScrollView {
            id: promptScroll
            anchors.top: prompttitle.bottom
            anchors.topMargin: 10
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height * 0.05
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width * 0.98
            clip:true
            Text {
                id: prompt
                width: promptBlock.width * 0.98
                height: promptBlock.height * 0.98
                wrapMode: Text.WordWrap
                padding:2
                text:qsTr("Write about something for some reason")
            }
        }


    }

    ESborder {
        id:noteBlock
        anchors.right: parent.right
        width: parent.width * 0.75
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.height * 0.1

        Text {
            id: title
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.margins: 10
            font.bold: true
            font.pointSize: 12
            text: qsTr("Composition")
        }

        Rectangle {
            anchors.top: title.bottom
            width: parent.width * 0.98
            anchors.horizontalCenter: parent.horizontalCenter
            height: 3
            color: seperatorColor
        }

        ScrollView {
            id: noteScroll
            anchors.top: title.bottom
            anchors.topMargin: 10
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height * 0.05
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width * 0.98

            background: ESTextField {
            }

            TextArea {
                id: lessonNotes
                width: noteBlock.width * 0.98
                height: noteBlock.height * 0.98
                wrapMode: Text.WordWrap
                selectByMouse: true
                onTextChanged: lessonUpdate = Scrubber.replaceSpecials(text)
            }
        }

        Text {
            anchors.top: noteScroll.bottom
            anchors.margins: 5
            anchors.right: noteScroll.right
            text: "Word count: " + (lessonNotes.text.split(" ").length - 1)
            visible: if ((lessonNotes.text.split(" ").length - 1) > 0) {
                         true
                     } else {
                         false
                     }
        }
    }
}

