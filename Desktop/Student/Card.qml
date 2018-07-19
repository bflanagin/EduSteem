import QtQuick 2.11
import QtQuick.Controls 2.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0
import Qt.labs.calendar 1.0

//import QtQuick.Extras 1.4
import "../theme"
import "../plugins"
import "../General"

import "../Educator/course.js" as Courses
import "../General/network.js" as Network
import "../Educator/students.js" as Students

ESborder {
    property string curtainColor: "white"
    property string title:"Class Name"
    property string unit:"Unit"
    property string lesson: "Lesson Name"
    property string discription: "Lesson Discription"

    states: [

        State {
            name:"In"

            PropertyChanges {
                target: nexttop
                height: parent.height * 0.4
            }
        },

        State {
            name:"Out"

            PropertyChanges {
                target: nexttop
                height: parent.height * 0.99
            }
        }

    ]

    state:"Out"

    transitions: [
        Transition {
            from: "Out"
            to: "In"
            reversible: true


            NumberAnimation {
                target: nexttop
                property: "height"
                duration: 500
                easing.type: Easing.InExpo
            }
        }
    ]

    Column {

        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.leftMargin: 10
        padding:5
        height: parent.height * 0.58
        width:parent.width * 0.98

        Text {
            text:qsTr("Discription: ") + discription
            width:parent.width * 0.9
            wrapMode: Text.WordWrap
        }
    }

    CircleButton {
        anchors.right:parent.right
        anchors.rightMargin: 15
        anchors.bottom:parent.bottom
        anchors.margins: 10
        icon:"/icons/media-playback-start.svg"
        width:24
        height:24
        fillcolor: "white"
    }

    Rectangle {
        id: nexttop
        anchors.top: parent.top
        anchors.topMargin: parent.height * 0.01
        width: parent.width * 0.99
        color: curtainColor
        anchors.horizontalCenter: parent.horizontalCenter

        Column {
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.leftMargin: 10
            width: parent.width * 0.94
            anchors.margins: parent.height * 0.1
            spacing: 3

            Text {
                font.bold: true
                text: title
                font.pointSize: parent.height * 0.3
                color: "white"
            }

            Text {
                text: qsTr("Unit: ") + unit
                font.pointSize: 12
                anchors.left: parent.left
                anchors.leftMargin: 10
                color: "white"
            }

            Text {
                text: qsTr("Lesson: ") + lesson
                font.pointSize: 12
                anchors.left: parent.left
                anchors.leftMargin: 10
                color: "white"
            }
        }
    }



    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: parent.state = "In"
        onExited: parent.state = "Out"
    }

}
