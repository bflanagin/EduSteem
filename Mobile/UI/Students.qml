import QtQuick 2.11
import QtQuick.Controls 2.4

import "../Plugins"
import "../Theme"
import "../Logic/general.js" as Scripts

Item {
    id: thisWindow
    width: parent.width
    height: if (visible == false) {
                0
            } else {
                parent.height
            }
    clip: true

    property real studentId: 0

    property string name: ""
    property int age: 0
    property string bday: ""
    property string about: ""
    property string phone: ""
    property string email: ""

    states: [

        State {
            name: "Active"
            PropertyChanges {
                target: thisWindow
                anchors.topMargin: 0
            }
        },

        State {
            name: "inActive"
            PropertyChanges {
                target: thisWindow
                anchors.topMargin: height * -1
            }
        }
    ]

    transitions: [
        Transition {
            from: "Active"
            to: "inActive"
            reversible: true

            NumberAnimation {
                target: thisWindow
                property: "anchors.topMargin"
                duration: 200
                easing.type: Easing.InOutQuad
            }
        }
    ]

    state: "inActive"

    onStateChanged: if (state === "Active") {
                        Scripts.loadStudent(studentId)
                    }

    Rectangle {
        anchors.fill: parent
        color: "#F9F9F9"
    }

    SwipeView {
        id: view

        currentIndex: 0
        anchors.fill: parent

        Item {
            id: firstPage
            width: thisWindow.width
            height: parent.height

            ESborder {
                anchors.bottom: parent.bottom
                anchors.bottomMargin: parent.width * 0.01
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width * 0.94
                height: parent.height * 0.8

                CircleButton {
                    id: profileImg
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: height * -0.5
                    width: parent.width * 0.5
                    height: width
                    icon: "../Icons/contact"
                    fillcolor: "white"
                }

                Column {
                    anchors.top: profileImg.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width * 0.95
                    height: parent.height - profileImg.height
                    spacing: parent.width * 0.03

                    Text {
                        font.bold: true
                        font.pointSize: 24
                        text: name
                    }

                    Item {
                        width: parent.width
                        height: agetext.height
                        Text {
                            id: agetext
                            anchors.left: parent.left
                            text: qsTr("Age: ") + age
                            font.pointSize: 18
                        }
                        Text {
                            anchors.right: parent.right
                            text: bday
                            font.pointSize: 18
                        }
                    }
                    Rectangle {
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: parent.width * 0.98
                        height: 1
                        color: seperatorColor
                    }

                    Text {
                        text: about
                        width: parent.width
                        wrapMode: Text.WordWrap
                        height: firstPage.height * 0.3
                    }

                    Text {
                        text: "Contact info"
                        font.pointSize: 18
                        font.bold: true
                    }
                    Rectangle {
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: parent.width * 0.98
                        height: 1
                        color: seperatorColor
                    }
                    Text {
                        text: qsTr("Phone: ") + phone
                        font.pointSize: 16
                    }
                    Text {
                        text: qsTr("Email: ") + email
                        font.pointSize: 16
                    }
                }
            }
        }
    }

    PageIndicator {
        id: indicator

        count: view.count
        currentIndex: view.currentIndex

        anchors.bottom: view.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }

    CircleButton {
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: 10
        width: 32
        height: 32
        icon: "../Icons/close.svg"
        fillcolor: "white"

        MouseArea {
            anchors.fill: parent
            onClicked: thisWindow.state = "inActive"
        }
    }
}
