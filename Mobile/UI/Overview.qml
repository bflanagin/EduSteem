import QtQuick 2.11
import QtQuick.Window 2.11
import QtQuick.Window 2.3
import QtQuick.Controls 2.2
import QtMultimedia 5.9
import QtQuick.Controls.Material 2.2

import "../Plugins"
import "../Theme"

import "../Logic/general.js" as Scripts

Item {
    id: thisWindow
    states: [

        State {
            name: "Active"
            PropertyChanges {
                target: shader
                anchors.topMargin: parent.height * -1
            }

            PropertyChanges {
                target: footer
                z: 2
            }

            PropertyChanges {
                target: filler
                visible: true
            }
        },

        State {
            name: "inActive"
            PropertyChanges {
                target: shader
                anchors.topMargin:0
            }

            PropertyChanges {
                target: footer
                z: -1
            }

            PropertyChanges {
                target: filler
                visible: false
            }
        }
    ]

    transitions: [
        Transition {
            from: "Active"
            to: "inActive"
            reversible: true

            NumberAnimation {
                target: shader
                property: "anchors.topMargin"
                duration: 200
                easing.type: Easing.InOutQuad
            }
        }
    ]

    state: "inActive"

    Timer {
        id:shadeTimer
        interval: 1000
        running: false
        repeat: false
       // onTriggered: thisWindow.state = "Active"
    }

    Rectangle {
        id: filler
        width: parent.width
        height: parent.height
    }

    Rectangle {
        id: shader
        width: parent.width
        height:parent.height
        anchors.top: parent.top
        color: highLightColor1
        z: 2
        Text {
            anchors.centerIn: parent
            text: schoolName.replace(/_/g, " ")
            color: "white"
            font.pointSize: 20
        }
    }

    Flickable {
        anchors.top: parent.top
        width: parent.width
        height: parent.height - footer.height
        clip: true
        contentHeight: cColumn.height + 50
        Column {
            id:cColumn
            width:parent.width

        DashBoard {
            id:dashBoard
            visible: true
            width: parent.width
        }

        StudentsList {
            id:studentList
            visible: false
            width:parent.width
        }

        SupplyView {
             id:supplyView
             visible: false
             height:if(visible == false) {0}
              width: parent.width
        }
        ScheduleView {
            id:scheduleView
            visible:false
            height:if(visible == false) {0}
            width:parent.width
        }

        }
    }

    ESborder {
        id: footer
        anchors.bottom: parent.bottom
        width: parent.width
        height: parent.height * 0.1
        z: -1

        Row {
            height: parent.height
            anchors.centerIn: parent
            spacing: thisWindow.width * 0.02

            ESButton {
                height: parent.height
                width: parent.height
                icon: "/Icons/icons8-school.svg"
                label: "Home"
                fillcolor: if(dashBoard.visible === true) {"white"} else {seperatorColor}

                Rectangle {
                    anchors.centerIn: parent
                    width:parent.width * 1.1
                    height:width
                    color:if(dashBoard.visible !== true) {"white"} else {seperatorColor}
                    z:-1
                }

                MouseArea {
                    anchors.fill:parent
                    onClicked: {Scripts.deselectAll()
                                    dashBoard.visible = true
                                }
                }
            }

            ESButton {
                height: parent.height
                width: parent.height
                icon: "/Icons/contact-group"
                label: "Students"
                fillcolor: if(studentList.visible === true) {"white"} else {seperatorColor}
                Rectangle {
                    anchors.centerIn: parent
                    width:parent.width * 1.1
                    height:width
                    color:if(studentList.visible !== true) {"white"} else {seperatorColor}
                    z:-1
                }

                MouseArea {
                    anchors.fill:parent
                    onClicked: {
                                Scripts.deselectAll()
                                studentList.visible = true
                                }
                }
            }

            ESButton {
                height: parent.height
                width: parent.height
                icon: "/Icons/edit-text.svg"
                label: "Supplies"
                fillcolor: if(supplyView.visible === true) {"white"} else {seperatorColor}

                Rectangle {
                    anchors.centerIn: parent
                    width:parent.width * 1.1
                    height:width
                    color:if(supplyView.visible !== true) {"white"} else {seperatorColor}
                    z:-1
                }

                MouseArea {
                    anchors.fill:parent
                    onClicked: {
                                Scripts.deselectAll()
                                supplyView.visible = true
                                }
                }
            }

            ESButton {
                height: parent.height
                width: parent.height
                icon: "/Icons/help"
                label: "Quiz"
                fillcolor: if(scheduleView.visible === true) {"white"} else {seperatorColor}

                Rectangle {
                    anchors.centerIn: parent
                    width:parent.width * 1.1
                    height:width
                    color:if(scheduleView.visible !== true) {"white"} else {seperatorColor}
                    z:-1
                }

                MouseArea {
                    anchors.fill:parent
                    onClicked: {Scripts.deselectAll()
                                scheduleView.visible = true
                                }
                }
            }

            ESButton {
                height: parent.height
                width: parent.height
                icon: "/Icons/message.svg"
                label: "Chat"
                fillcolor: seperatorColor

                Rectangle {
                    anchors.centerIn: parent
                    width:parent.width * 1.1
                    height:width

                    z:-1
                }
            }
        }
    }
}
