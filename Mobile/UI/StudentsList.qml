import QtQuick 2.11

import "../Theme/"
import "../UI"

import "../Logic/general.js" as Scripts

Item {
    id:thisWindow
    width: parent.width
    height: if (visible == false) {0 } else {
                cColumn.height + 19
            }

    property int sorting: 0


    onVisibleChanged: if(visible === true) {Scripts.loadStudents(schoolCode,sorting) }
    Column {
        id: cColumn
        anchors.top:parent.top
        anchors.topMargin: parent.width * 0.04
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width * 0.98
        spacing: parent.width * 0.05

        Item {
            width: parent.width
            height: thisWindow.width * 0.13
            clip:true
            Text {
                id: title
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: parent.width * 0.05
                text: qsTr("Students")
                font.bold: true
                font.pointSize: 24
            }

            ESButton {
                anchors.right:parent.right
                anchors.rightMargin: parent.height * 0.1
                anchors.verticalCenter: parent.verticalCenter
                width:height
                height:parent.height
                fillcolor: "black"
                label:switch(sorting) {
                            case 0: qsTr("First Name")
                                break
                            case 1: qsTr("Last Name")
                                break
                      }
                icon:"../Icons/sort-descending"

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                                if(sorting === 0) {sorting = 1} else {sorting = 0}
                        Scripts.loadStudents(schoolCode,sorting)

                    }
                }

            }

            Rectangle {
                anchors.bottom:parent.bottom
                width:parent.width * 0.98
                height: 2
                color:seperatorColor
            }
        }



        Repeater {
            model: students

            delegate: ESborder {
                width: parent.width
                height: 50

                Item {
                    width: parent.width * 0.98
                    height: parent.height * 0.98
                    anchors.centerIn: parent
                    clip: true

                    Row {
                        width: parent.width
                        height: parent.height
                        spacing: width * 0.1

                        CircleButton {
                            width: parent.height * 0.98
                            height: width
                            fillcolor: "white"
                            icon: "../Icons/contact"
                        }

                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            text: name
                            font.pixelSize: parent.height * 0.6
                        }
                    }
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                                studentView.studentId = id
                                studentView.state = "Active"
                                }
                }
            }
        }
    }

    ListModel {
        id: students
    }
}
