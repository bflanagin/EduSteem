import QtQuick 2.11
import QtQuick.Controls 2.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0

//import QtQuick.Extras 1.4
import "../theme"
import "../plugins"
import "../Educator/scheduler.js" as Schedule
import "../Educator/course.js" as Courses
import "../Educator/students.js" as Students
import "steemit.js" as Steem
import "../plugins/markdown.js" as Marks
import "./network.js" as Network

Item {
    id: thisWindow

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
                anchors.leftMargin: -1 * thisWindow.width
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
                property: "anchors.leftMargin"
                duration: 100
                easing.type: Easing.InOutQuad
            }
        }
    ]

    state: "inActive"

    Rectangle {
        anchors.fill: parent
        color: menuColor
    }

    ScrollView {
        width: parent.width
        height: leftMenu.height
        contentHeight: (leftColumn.height + adminColumn.height) * 1.1
        contentWidth: parent.width
        clip: true

        Column {
            id: leftColumn
            anchors.top: parent.top
            anchors.bottomMargin: 3

            width: leftMenu.width
            anchors.left: parent.left
            anchors.leftMargin: 2

            spacing: 10

            Column {
                id: studentGeneral

                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width
                spacing: 4

                visible: if (studentHome.state == "Active") {
                             true
                         } else {
                             false
                         }

                Rectangle {
                    width: parent.width * 0.98
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "Transparent"
                    height: 3
                }

                ESButton {
                    width: leftMenu.width * 0.9
                    height: leftMenu.width * 0.9
                    anchors.horizontalCenter: parent.horizontalCenter
                    label: qsTr("Your Profile")
                    icon: "../icons/contact.svg"

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            schedule.state = "inActive"
                            rightMenu.state = "Active"
                            general.state = "inActive"
                            student.state = "inActive"
                            studentRoster.state = "inActive"
                            yourProfile.state = "Active"
                            yourProfile.userid = userCode
                        }
                    }
                }

                ESButton {
                    width: leftMenu.width * 0.9
                    height: leftMenu.width * 0.9
                    anchors.horizontalCenter: parent.horizontalCenter
                    label: qsTr("Activities")
                    icon: "/icons/star.svg"

                    MouseArea {
                        anchors.fill: parent
                    }
                }

                ESButton {
                    width: leftMenu.width * 0.9
                    height: leftMenu.width * 0.9
                    anchors.horizontalCenter: parent.horizontalCenter
                    label: qsTr("Store")
                    icon: "/icons/Next.svg"

                    MouseArea {
                        anchors.fill: parent
                    }
                }
            }

            Column {
                id: educatorGeneral

                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width
                spacing: 2

                visible: if (studentHome.state != "Active") {
                             true
                         } else {
                             false
                         }

                ESButton {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: leftMenu.width * 0.9
                    height: leftMenu.width * 0.9
                    icon: "/icons/bookmark.svg"
                    label: qsTr("Courses")

                    MouseArea {
                        anchors.centerIn: parent
                        width: parent.width * 3
                        height: parent.height
                        hoverEnabled: true
                        propagateComposedEvents: true

                        onEntered: {
                            submenuLeft.state = "Active"
                            parent.entered = true
                        }
                        onExited: {
                            submenuLeft.closing = true
                            parent.entered = false
                        }
                    }
                }

                ESButton {
                    width: leftMenu.width * 0.9
                    height: leftMenu.width * 0.9
                    anchors.horizontalCenter: parent.horizontalCenter
                    label: qsTr("Activities")
                    icon: "/icons/Next.svg"

                    MouseArea {
                        anchors.fill: parent
                    }
                }

                ESButton {
                    width: leftMenu.width * 0.9
                    height: leftMenu.width * 0.9
                    anchors.horizontalCenter: parent.horizontalCenter
                    label: qsTr("Your Profile")
                    icon: "../icons/contact.svg"

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            schedule.state = "inActive"
                            rightMenu.state = "Active"
                            general.state = "inActive"
                            student.state = "inActive"
                            studentRoster.state = "inActive"
                            yourProfile.state = "Active"
                            yourProfile.userid = userCode
                        }
                    }
                }
            }

            Rectangle {
                width: parent.width * 0.98
                anchors.horizontalCenter: parent.horizontalCenter
                color: "Transparent"
                height: 3
            }
        }
    }

    Column {
        id: adminColumn
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        width: parent.width * 0.98

        visible: if (studentHome.state != "Active") {
                     true
                 } else {
                     false
                 }

        ESButton {
            width: leftMenu.width * 0.9
            height: leftMenu.width * 0.9
            anchors.horizontalCenter: parent.horizontalCenter
            label: qsTr("Roster")
            icon: "/icons/contact-group.svg"

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    studentRoster.state = "Active"
                    rightMenu.state = "Active"
                    schedule.state = "inActive"
                    general.state = "inActive"
                    course.state = "inActive"
                    student.state = "inActive"
                    yourProfile.state = "inActive"
                }
            }
        }

        ESButton {
            width: leftMenu.width * 0.9
            height: leftMenu.width * 0.9
            anchors.horizontalCenter: parent.horizontalCenter
            label: qsTr("Schedule")
            icon: "/icons/calendar.svg"

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    schedule.state = "Active"
                    rightMenu.state = "Active"
                    general.state = "inActive"
                    student.state = "inActive"
                    studentRoster.state = "inActive"
                    yourProfile.state = "inActive"
                }
            }
        }

        ESButton {
            width: leftMenu.width * 0.9
            height: leftMenu.width * 0.9
            anchors.horizontalCenter: parent.horizontalCenter
            label: qsTr("Settings")
            icon: "/icons/edit.svg"

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    settingsPage.state = "Active"
                    schedule.state = "inActive"
                    rightMenu.state = "inActive"
                    general.state = "inActive"
                    student.state = "inActive"
                    studentRoster.state = "inActive"
                    yourProfile.state = "inActive"
                }
            }
        }
    }

    Text {
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.margins: 4
        text: schoolCode
        opacity: 0.5
        font.pointSize: 5
    }
}
