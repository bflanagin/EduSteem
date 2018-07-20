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
import "./student.js" as Students

Item {
    id: thisWindow

    property real lessonID: 0
    property string lessonName: ""
    property string lessonAuthor: ""
    property string lessonPublished: ""
    property string lessonAbout: ""
    property string lessonObjective: ""

    property string lessonResources: ""
    property string lessonSupplies: ""

    property string lessonGQ: ""
    property string guidedQuestions: ""
    property string reviewQuestions: ""

    property int lessonDuration: 0
    property int lessonOrder: 0
    property string lessonDate: ""

    property string lessonSequence: ""
    property string lessonSP: ""

    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter

    states: [

        State {
            name: "Active"
            PropertyChanges {

                target: thisWindow
                opacity: 1
                anchors.verticalCenterOffset: 0
            }
        },

        State {
            name: "inActive"
            PropertyChanges {

                target: thisWindow
                opacity: 0
                anchors.verticalCenterOffset: parent.height + 500
            }
        }
    ]

    transitions: [
        Transition {
            from: "inActive"
            to: "Active"
            reversible: true

            NumberAnimation {
                target: thisWindow
                properties: "opacity,anchors.verticalCenterOffset"
                duration: 40
                easing.type: Easing.InOutQuad
            }
        }
    ]

    state: "inActive"

    onLessonIDChanged: if (lessonID !== 0) {
                           Students.loadTask(studentCode, lessonID)
                       }

    Rectangle {
        anchors.fill: parent
    }

    TopBar {
        id: topBar
        width: parent.width
        height: 32
    }

    Item {
        id: mainArea
        anchors.top: topBar.bottom
        anchors.left: leftMenu.right
        anchors.margins: 4
        width: parent.width - leftMenu.width
        height: parent.height - topBar.height

        ESborder {
            id:controlArea
            width: parent.width * 0.99
            //anchors.horizontalCenter: parent.horizontalCenter
            height: controlColumn.height + 10
            state:"Active"

            Column {
                id: controlColumn
                anchors.centerIn: parent
                width: parent.width * 0.98
                spacing: 8

                Text {
                    font.bold: true
                    font.pointSize: 18
                    text: lessonName
                }
                Text {
                    text: qsTr("Author: ")+lessonAuthor
                }

                Rectangle {

                    anchors.horizontalCenter: controlArea.horizontalCenter
                    width:controlArea.width * 0.98
                    height:8
                    color:"transparent"
                }

                Item {
                    width:parent.width
                    height:breakbutton.height + 10
                    Button {
                        id:breakbutton
                        anchors.left:parent.left
                        anchors.leftMargin: parent.width * 0.01
                        anchors.verticalCenter: parent.verticalCenter
                        text: qsTr("Take a Break")
                        background: ESTextField {

                        }
                    }

                    Button {
                        anchors.right:parent.right
                        anchors.rightMargin: parent.width * 0.01
                        anchors.verticalCenter: parent.verticalCenter
                        text: qsTr("Turn In")
                        background: ESTextField {
                        }

                    }

                }
            }
        }

        ScrollView {
            anchors.top:controlArea.bottom
            anchors.topMargin: 5
            anchors.right:parent.right
            anchors.rightMargin: 8

            width:mainArea.width * 0.33
            height:parent.height - topBar.height
            contentHeight:cColumn.height + 10
            contentWidth: mainArea.width

            ESborder {
                width:cColumn.width + 10
                height:cColumn.height + 10
                anchors.centerIn: cColumn

            Column {
                id:cColumn
                width:mainArea.width * 0.31
                anchors.centerIn: parent
                spacing: 8

                Text {
                    text:qsTr("Supplies")
                    font.bold: true
                    Rectangle {
                        anchors.bottom:parent.bottom
                        anchors.bottomMargin: -4
                        anchors.horizontalCenter: cColumn.horizontalCenter
                        width:cColumn.width * 0.98
                        height:2
                        color:seperatorColor
                    }
                }

                    MarkDown {
                        anchors.left: parent.left
                        anchors.margins: 8
                        width:parent.width
                        thedata: lessonSupplies

                    }

                    Text {
                        text:qsTr("Resources")
                        font.bold: true
                        Rectangle {
                            anchors.bottom:parent.bottom
                            anchors.bottomMargin: -4
                            anchors.horizontalCenter: cColumn.horizontalCenter
                            width:cColumn.width * 0.98
                            height:2
                            color:seperatorColor
                        }
                    }

                    MarkDown {
                        anchors.left: parent.left
                        anchors.margins: 8
                        width:parent.width
                        thedata: lessonResources

                    }

                    Text {
                        text:qsTr("Instructions")
                        font.bold: true
                        Rectangle {
                            anchors.bottom:parent.bottom
                            anchors.bottomMargin: -4
                            anchors.horizontalCenter: cColumn.horizontalCenter
                            width:cColumn.width * 0.98
                            height:2
                            color:seperatorColor
                        }
                    }

                    MarkDown {
                        anchors.left: parent.left
                        anchors.margins: 8
                        width:parent.width
                        thedata: lessonSP

                    }
                }



            }
        }
    }

    LeftMenu {
        id: leftMenu
        anchors.left: parent.left
        anchors.top: topBar.bottom
        anchors.bottom: parent.bottom
        state: "Active"
        width: 64
        clip: true
        z: 5
    }
}
