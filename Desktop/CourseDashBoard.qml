import QtQuick 2.11
import QtQuick.Controls 2.2

import "./theme"
import "./plugins"

import "./course.js" as Scripts

Item {
id:thisWindow

property real coursenumber: 0
property string courseName: "Course Name"

    states: [

            State {
                name:"Active"
                    PropertyChanges {

                        target:thisWindow
                        opacity:1
                        anchors.verticalCenterOffset: 0

                    }

                },

        State {
            name:"inActive"
                PropertyChanges {

                    target:thisWindow
                    opacity:0
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

    state:"inActive"

    onStateChanged: if(state == "Active") {Scripts.loadCourse(userid,coursenumber)} else {}

    Text {
        id:title
        text: courseName
        anchors.top:parent.top
        anchors.left: parent.left
        anchors.margins: 20
        font.bold: true
        font.pointSize: 15
    }

    Button {
        anchors.verticalCenter: title.verticalCenter
        //anchors.top:parent.top
        anchors.right:parent.right
        anchors.margins: 20
        text:qsTr("Add Unit")
        background:ESTextField {}
    }


    Rectangle {
        anchors.top:title.bottom
        anchors.topMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width * 0.95
        height: 3
        color: seperatorColor
    }

    Flickable {
        anchors.top:title.bottom
        anchors.topMargin: 24
        anchors.bottom:parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        width:parent.width * 0.98
        contentHeight: cColumn.height * 1.02
        clip: true
        Column {
            anchors.top: parent.top
            anchors.topMargin: 10
            id: cColumn
            width: parent.width
            spacing: mainView.width * 0.01


            ListView {
                anchors.horizontalCenter: parent.horizontalCenter
                width:thisWindow.width * 0.98
                height:contentHeight
                clip:true
                spacing: thisWindow.height * 0.02

                model:3

                delegate: ESborder {
                            anchors.horizontalCenter: parent.horizontalCenter
                            width:thisWindow.width * 0.98
                            height:lessons.height * 1.03

                           /* Rectangle {anchors.fill: parent
                                    color:if(index % 2) {"#FFFFFF"} else {"#FAFAFA"}
                                    border.width: 1
                            } */
                            Row {
                                anchors.horizontalCenter: parent.horizontalCenter
                                width:parent.width * 0.98
                                height:lessons.height

                            Column {
                                id:unitColumn

                                width:parent.width * 0.40
                                spacing:thisWindow.height * 0.02

                                Text {
                                    padding: 10
                                    text:"Unit "+index
                                    font.bold: true
                                }

                                Text {

                                    text: "This unit goes over things and stuff"
                                    padding: 15
                                    width:parent.width
                                    wrapMode: Text.WordWrap
                                }

                            }

                            ListView {
                                id:lessons
                                height:contentHeight
                                width:parent.width * 0.60
                                spacing:thisWindow.height * 0.02

                                model: 3

                                delegate: ESborder {
                                                width:thisWindow.width * 0.58
                                                height:lessonColumn.height * 1.02


                                            Column {
                                                id:lessonColumn
                                                width:parent.width * 0.99
                                                spacing:thisWindow.height * 0.02

                                                anchors.centerIn: parent

                                                Text {
                                                    text:"Title"
                                                    padding: 10
                                                }
                                                Text {
                                                    text:"Other stuff"
                                                    padding: 10
                                                }
                                            }
                                }

                            }

                         }
                }
            }
        }

    }

}
