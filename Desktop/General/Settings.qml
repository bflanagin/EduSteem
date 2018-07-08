import QtQuick 2.11
import QtQuick.Controls 2.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0

import "../theme"
import "../plugins"
import "../Educator/course.js" as Scripts
import "../General/network.js" as Network
import "../plugins/text.js" as Scrubber

Item {
    id: thisWindow

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

    Rectangle {
        anchors.fill: parent
    }

    Text {
        id: title
        text: qsTr("Settings")
        anchors.top: parent.top
        anchors.left: backbutton.right
        anchors.margins: 20
        font.bold: true
        font.pointSize: 15
    }

    CircleButton {
        id: backbutton
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 20
        height: title.height
        width: title.height

        MouseArea {
            anchors.fill: parent
            onClicked: {
                thisWindow.state = "inActive"
                general.state = "Active"
            }
        }
    }

    Rectangle {
        anchors.top: title.bottom
        anchors.topMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width * 0.95
        height: 3
        color: seperatorColor
    }

    Flickable {
        anchors.top: title.bottom
        anchors.topMargin: 24
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width * 0.98
        contentHeight: cColumn.height

        clip: true

        Column {
            id: cColumn
            width: parent.width
            spacing: 10

            ESborder {
                anchors.horizontalCenter: parent.horizontalCenter
                width: thisWindow.width * 0.98
                height: aboutColumn.height + 23

                Column {
                    id: aboutColumn
                    anchors.top: parent.top
                    anchors.topMargin: 10
                    width: parent.width * 0.98
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 3

                    Text {
                        anchors.left: parent.left
                        font.bold: true
                        text: qsTr("About")
                    }

                    Rectangle {
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: parent.width * 0.99
                        height: 2
                        color: seperatorColor
                    }

                    Text {
                        id: about
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                        text: schoolAbout
                        wrapMode: Text.WordWrap
                        width: parent.width * 0.85
                    }

                    Image {
                        anchors.right: parent.right
                        anchors.rightMargin: 10
                        source: "/icons/edit-text.svg"
                        width: 24
                        height: 24
                        fillMode: Image.PreserveAspectFit

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                editthis.field = "About"
                                editthis.where = "school"
                                editthis.state = "Active"
                            }
                        }
                    }
                }
            }

            Row {
                width: parent.width * 0.98

                ESborder {

                    width: thisWindow.width * 0.49
                    height: startColumn.height + 23

                    Column {
                        id: startColumn
                        anchors.top: parent.top
                        anchors.topMargin: 10
                        width: parent.width * 0.98
                        anchors.horizontalCenter: parent.horizontalCenter
                        spacing: 3

                        Text {
                            anchors.left: parent.left
                            font.bold: true
                            text: qsTr("School Day:")
                        }

                        Rectangle {
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: parent.width * 0.99
                            height: 2
                            color: seperatorColor
                        }

                        Image {
                            anchors.right: parent.right
                            anchors.rightMargin: 10
                            source: "/icons/edit-text.svg"
                            width: 24
                            height: 24
                            fillMode: Image.PreserveAspectFit

                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    editthis.field = "About"
                                    editthis.where = "school"
                                    editthis.state = "Active"
                                }
                            }
                        }
                    }
                }

                ESborder {

                    width: thisWindow.width * 0.49
                    height: dowColumn.height + 23

                    Column {
                        id: dowColumn
                        anchors.top: parent.top
                        anchors.topMargin: 10
                        width: parent.width * 0.98
                        anchors.horizontalCenter: parent.horizontalCenter
                        spacing: 3

                        Text {
                            anchors.left: parent.left
                            font.bold: true
                            text: qsTr("Weekly Schedule")
                        }

                        Rectangle {
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: parent.width * 0.99
                            height: 2
                            color: seperatorColor
                        }

                        Image {
                            anchors.right: parent.right
                            anchors.rightMargin: 10
                            source: "/icons/edit-text.svg"
                            width: 24
                            height: 24
                            fillMode: Image.PreserveAspectFit

                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    editthis.field = "About"
                                    editthis.where = "school"
                                    editthis.state = "Active"
                                }
                            }
                        }
                    }
                }
            }

            ESborder {
                anchors.horizontalCenter: parent.horizontalCenter
                width: thisWindow.width * 0.98
                height: teacherColumn.height + 23

                Column {
                    id: teacherColumn
                    anchors.top: parent.top
                    anchors.topMargin: 10
                    width: parent.width * 0.98
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 3

                    Text {
                        anchors.left: parent.left
                        font.bold: true
                        text: qsTr("Registered Instructors")
                    }

                    Rectangle {
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: parent.width * 0.99
                        height: 2
                        color: seperatorColor
                    }

                    Image {
                        anchors.right: parent.right
                        anchors.rightMargin: 10
                        source: "/icons/edit-text.svg"
                        width: 24
                        height: 24
                        fillMode: Image.PreserveAspectFit

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                editthis.field = "About"
                                editthis.where = "school"
                                editthis.state = "Active"
                            }
                        }
                    }
                }
            }
        }
    }
}
