import QtQuick 2.11
import QtQuick.Controls 2.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0

import "./students.js" as Students
import "../theme"

Item {
    id: thisWindow

    property string studentCode: ""
    property string studentname:"Student"

    onStudentCodeChanged:Students.loadStudent(studentCode)


    states: [

        State {
            name: "Active"
            PropertyChanges {

                target: thisWindow
                //opacity: 1
                x:leftMenu.width
            }
        },

        State {
            name: "inActive"
            PropertyChanges {

                target: thisWindow
                //opacity: 0
                x: -parent.width
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
                properties: "x"
                duration: 100
                easing.type: Easing.InOutQuad
            }
        }
    ]

    state: "inActive"

    Rectangle {
        anchors.fill: parent
    }

    Text {
        id:title
        text: studentname
        anchors.top:parent.top
        anchors.left: backbutton.right
        anchors.margins: 20
        font.bold: true
        font.pointSize: 15
    }

    CircleButton {
        id:backbutton
        anchors.top:parent.top
        anchors.left:parent.left
        anchors.margins: 20
        height:title.height
        width:title.height

        MouseArea {
            anchors.fill: parent
            onClicked: { thisWindow.state = "inActive"
                         studentRoster.state = "Active"

                        }
        }
    }

    Text {
        text:qsTr("Today")
        font.bold: true
        anchors.right:parent.right
        anchors.verticalCenter: title.verticalCenter
        anchors.margins: 30
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
        anchors.topMargin: 20
        anchors.bottom:parent.bottom
        width:parent.width
        contentHeight: cColumn.height
        clip: true
        Column {
            anchors.top: parent.top
            anchors.topMargin: 10
            id: cColumn
            width: parent.width
            spacing: mainView.width * 0.01



            Row {

                width: parent.width
                height: thisWindow.height * 0.2

                Item {
                    width: parent.width * 0.33
                    height: parent.height

                    Dial {
                        id: mathDial
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: parent.height * 0.8
                        height: parent.height * 0.8
                        from: 0
                        to: 100
                        value: 90
                        visible: false

                        handle: Rectangle {
                            visible: false
                        }

                        Item {
                            anchors.fill: parent

                            Text {
                                width: parent.width * 0.8
                                horizontalAlignment: Text.AlignHCenter
                                anchors.centerIn: parent
                                font.pixelSize: parent.width * 0.2
                                text: mathDial.value + "%"
                            }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: console.log("nope")
                            }
                        }
                    }

                    ColorOverlay {
                        source: mathDial
                        anchors.fill: mathDial
                        color: seperatorColor
                        antialiasing: true
                    }

                    Text {
                        anchors.bottom: parent.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: "Math"
                    }
                }

                Item {
                    width: parent.width * 0.33
                    height: parent.height

                    Dial {
                        id: spellingDial
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: parent.height * 0.8
                        height: parent.height * 0.8
                        from: 0
                        to: 100
                        value: 70
                        visible: false

                        handle: Rectangle {
                            visible: false
                        }

                        Item {
                            anchors.fill: parent

                            Text {
                                width: parent.width * 0.8
                                horizontalAlignment: Text.AlignHCenter
                                anchors.centerIn: parent
                                font.pixelSize: parent.width * 0.2
                                text: spellingDial.value + "%"
                            }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: console.log("nope")
                            }
                        }
                    }

                    ColorOverlay {
                        source: spellingDial
                        anchors.fill: spellingDial
                        color: seperatorColor
                        antialiasing: true
                    }

                    Text {
                        anchors.bottom: parent.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: "Spelling"
                    }
                }

                Item {
                    width: parent.width * 0.33
                    height: parent.height

                    Dial {
                        id: factsDial
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: parent.height * 0.8
                        height: parent.height * 0.8
                        from: 0
                        to: 100
                        value: 95
                        visible: false

                        handle: Rectangle {
                            visible: false
                        }

                        Item {
                            anchors.fill: parent

                            Text {
                                width: parent.width * 0.8
                                horizontalAlignment: Text.AlignHCenter
                                anchors.centerIn: parent
                                font.pixelSize: parent.width * 0.2
                                text: factsDial.value + "%"
                            }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: console.log("nope")
                            }
                        }
                    }

                    ColorOverlay {
                        source: factsDial
                        anchors.fill: factsDial
                        color: seperatorColor
                        antialiasing: true
                    }

                    Text {
                        anchors.bottom: parent.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: "Facts"
                    }
                }
            }

            Rectangle {
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width * 0.95
                height: 3
                color: seperatorColor
            }

            ListView {
                width:thisWindow.width
                height:contentHeight
                clip:true
                spacing: thisWindow.height * 0.01

                model:3

                delegate: Item {
                            width:thisWindow.width
                            height:classColumn.height * 1.03

                            Rectangle {anchors.fill: parent
                                    color:if(index % 2) {"#FFFFFF"} else {"#FAFAFA"}
                            }

                            Column {
                                id:classColumn
                                anchors.centerIn: parent
                                width:parent.width * 0.98
                                spacing:thisWindow.height * 0.02

                                Text {
                                    text:"Course "+index
                                    font.bold: true
                                }
                                Text {
                                    width: parent.width * 0.9
                                    wrapMode: Text.WordWrap
                                    text:"Objective:"+ "Today you will need to write a paragraph about the observations you made during the activity we did earlier."

                                }


                            }
                }
            }

        }
    }
}
