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

import "./course.js" as Courses
import "../General/network.js" as Network
import "./students.js" as Students

Item {
    id: thisWindow

    property string guidedQuestions: ""
    property var reviewQuestions: []

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

    onStateChanged: if (state == "Active") {
                        Courses.loadCourses(userid)
                        Students.loadStudents(schoolCode)

                        Network.checkOpenSeed(userid, schoolCode,
                                              schoolEditDate, "School")
                        Network.checkOpenSeed(userid, userid, userEditDate,
                                              "Educator")
                    }

    Timer {
        id: checkforUpdates
        interval: 4000
        repeat: true
        onTriggered: if (state == "Active") {
                         Network.sync("Courses", schoolCode)
                         Network.sync("Units", schoolCode)
                         Network.sync("Lessons", schoolCode)
                         Network.sync("Students", schoolCode)
                         checkforUpdates.interval = 20000
                     }
    }

    Rectangle {
        anchors.fill: parent
    }

    TopBar {
        id: topBar
        width: parent.width
        height: 32
    }

    SubMenu {
        id: submenuLeft
        width: 200
        anchors.left: leftMenu.right
        anchors.top: topBar.bottom
        anchors.bottom: parent.bottom
        clip: true
        z: 4
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

    ListModel {
        id: courseList
    }

    ListModel {
        id: studentList
    }

    Item {
        id: middleArea
        anchors.left: leftMenu.right
        anchors.right: if (rightMenu.state == "Active") {
                           rightMenu.left
                       } else {
                           parent.right
                       }
        anchors.top: topBar.bottom
        anchors.bottom: parent.bottom

        GeneralInfoDashBoard {
            id: general

            anchors.verticalCenter: parent.verticalCenter
            height: parent.height
            width: parent.width
            state: "Active"
        }

        CourseDashBoard {
            id: course

            width: parent.width
            anchors.verticalCenter: parent.verticalCenter
            height: parent.height
            state: "inActive"
            onStateChanged: if (state == "inActive") {
                                Courses.loadCourses(userid)
                            }
        }

        Scheduler {
            id: schedule
            width: parent.width
            anchors.verticalCenter: parent.verticalCenter
            height: parent.height
            state: "inActive"
        }

        Profile {
            id: yourProfile
            width: parent.width
            height: parent.height
            state: "inActive"
        }

        Roster {
            id: studentRoster
            width: parent.width
            anchors.verticalCenter: parent.verticalCenter
            height: parent.height
            state: "inActive"
        }

        StudentDashBoard {
            id: student

            width: parent.width
            anchors.verticalCenter: parent.verticalCenter
            height: parent.height
            state: "inActive"
        }

        Settings {
            id: settingsPage
            width: parent.width
            height: parent.height
            state: "inActive"
        }
    }

    RightMenu {
        id: rightMenu
        anchors.right: parent.right
        anchors.top: topBar.bottom
        anchors.bottom: parent.bottom
        width: if (parent.width * 0.20 > 600) {
                   600
               } else {
                   parent.width * 0.20
               }
        state: "inActive"
    }

    CourseWizard {
        id: cWizard
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: leftMenu.width / 2
        state: "inActive"
        width: 800

        onStateChanged: if (state == "inActive") {
                            Courses.loadCourses(userid)
                        }
    }

    NewStudentAccount {
        id: newStudent
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: leftMenu.width / 2
        state: "inActive"
        width: 800

        onStateChanged: if (state == "inActive") {
                            Students.loadStudents(schoolCode)
                        }
    }

    ClassEdit {
        id: classEdit
        width: 800
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: leftMenu.width / 2
        state: "inActive"
    }

    ListModel {
        id: gqList
    }

    ListModel {
        id: rqList
    }
}
