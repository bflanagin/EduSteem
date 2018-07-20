import QtQuick 2.11
import QtQuick.Controls 2.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0

import "../theme"
import "../plugins"
import "../General"

import "../Educator/course.js" as Courses
import "../General/network.js" as Network
import "../Educator/students.js" as Students

Item {
    id: thisWindow
    property bool closing: false

    states: [

        State {
            name: "Active"
            PropertyChanges {
                target: thisWindow
                anchors.leftMargin: 0
            }
        },

        State {
            name: "inActive"
            PropertyChanges {
                target: thisWindow
                anchors.leftMargin: -1 * width
            }
        }
    ]

    state: "inActive"

    transitions: [
        Transition {
            from: "Active"
            to: "inActive"
            reversible: true

            NumberAnimation {
                target: thisWindow
                property: "anchors.leftMargin"
                duration: 200
                easing.type: Easing.InOutQuad
            }
        }
    ]

    Timer {
        id:courseMenuClose
        interval: 400
        running: closing
        repeat: false
        onTriggered: thisWindow.state = "inActive"
    }

    onStateChanged: if(state == "inActive") {closing = false}


    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: thisWindow.state = "Active"
        onExited: thisWindow.state = "inActive"
        propagateComposedEvents: true
    }



    Rectangle {
        anchors.fill: parent
        color: submenu
    }

    ListView {
        anchors.top: parent.top
        anchors.topMargin: 10
        width: parent.width
        //height:if(contentHeight < 210) {contentHeight} else {210}
        height: contentHeight
        spacing: 20
        clip: true
        model: courseList
        ScrollIndicator.vertical: ScrollIndicator {
        }

        delegate: Item {
            width: parent.width
            height: thisWindow.width * 0.2

            Component.onCompleted: {
                Network.checkOpenSeed(userID, cdate, edate, "Courses")
            }

            Rectangle {
                id: background
                anchors.fill: parent
                color: if (index % 2) {
                           "#FFFFFF"
                       } else {
                           "#FAFAFA"
                       }
                opacity: 0
            }
            Row {
                width: parent.width * 0.98
                height: parent.height

                Item {
                    width: parent.width - parent.height / 2
                    height: parent.height

                    Text {
                        anchors.centerIn: parent
                        width: parent.width
                        wrapMode: Text.WordWrap
                        padding: 10
                        text: name.trim()
                        color:color1
                        font.pointSize: 8
                        horizontalAlignment: Text.AlignLeft
                    }
                }
                Item {
                    width: parent.height * 0.7
                    height: parent.height * 0.7
                    anchors.verticalCenter: parent.verticalCenter
                    Image {
                        id: icon
                        width: parent.width
                        height: parent.height

                        source: "/icons/Next.svg"
                        fillMode: Image.PreserveAspectFit
                        visible: false
                    }

                    ColorOverlay {
                        anchors.fill: icon
                        color: color1
                        source: icon
                    }
                }
            }
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    thisWindow.state = "Active"
                    background.opacity = 0.1
                }

                onExited: {
                    thisWindow.state = "inActive"
                    background.opacity = 0
                }

                propagateComposedEvents: true
                onClicked: {
                    thisWindow.state = "inActive"
                    rightMenu.state = "inActive"
                    course.coursenumber = cdate
                    course.state = "Active"

                    general.state = "inActive"
                    student.state = "inActive"
                    schedule.state = "inActive"
                    studentRoster.state = "inActive"
                    yourProfile.state = "inActive"
                }
            }
        }
    }

    ESButton {
        anchors.bottom:parent.bottom
        anchors.right: parent.right
        width:parent.width * 0.3
        height: parent.width * 0.3
        icon:"../icons/add.svg"
        label:qsTr("Add Course")


            MouseArea {
                anchors.fill: parent
               hoverEnabled: true
                onEntered: {
                    thisWindow.state = "Active"
                    parent.entered = true
                    //background.opacity = 0.1
               }

                onExited: {
                    thisWindow.state = "inActive"
                    parent.entered = false
                    //background.opacity = 0
                }

                propagateComposedEvents: true

                onClicked: {
                    cWizard.state = "Active"
                }

            }






    }
}
