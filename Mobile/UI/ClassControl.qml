import QtQuick 2.11
import QtQuick.Window 2.11
import QtQuick.Window 2.3
import QtQuick.Controls 2.2
import QtMultimedia 5.9
import QtQuick.Controls.Material 2.2

import "../Plugins"
import "../Theme"

Item {
    id:thisWindow

    property string lessonName:"Lesson"
    property string unit:"Unit Name"
    property string course: "Course"
    property string about: "About"

    clip:true

    Column {
        anchors.top:parent.top
        anchors.topMargin: parent.width * 0.02
        anchors.horizontalCenter: parent.horizontalCenter
        width:parent.width * 0.98
        spacing: parent.width * 0.04

        Text {

            text: lessonName
            font.bold: true
            font.pointSize: 24
        }


        Text {
            anchors.right:parent.right
            anchors.rightMargin: parent.width * 0.03
            text: unit
             font.pointSize: 16
        }

        Text {
            anchors.right:parent.right
            anchors.rightMargin: parent.width * 0.03
            text: course
             font.pointSize: 16
        }

        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            width:parent.width * 0.98
            height: 2
            color:seperatorColor

        }

        Text {
            text: about
            width:parent.width
            height:parent.height * 0.65
            wrapMode: Text.WordWrap
        }

        Item {
            anchors.horizontalCenter: parent.horizontalCenter
            width:parent.width * 0.98
            height:stopButton.height

            Button {
                id:stopButton
                anchors.left:parent.left
                text: "Stop"
                background: ESTextField{}
            }

            Button {
                anchors.right: parent.right
                text: "Start"
                background: ESTextField{}
            }

        }
    }

}
