import QtQuick 2.11
import QtQuick.Controls 2.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0
import Qt.labs.calendar 1.0

import "../theme"
import "../plugins"
import "../General"

import "../Educator/course.js" as Courses
import "../General/network.js" as Network
import "./student.js" as Students
import "../Educator/scheduler.js" as Schedule
import "../General/general.js" as Scripts

Item {
    id: thisWindow

    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter


    property string studentFirstName: ""
    property string studentLastName: ""
    property int ticktock: 0


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

    onStateChanged: if(thisWindow.state === "Active") {
                        Students.loadDay(d.getMonth(),d.getDate(),d.getDay(),studentCode)
                        Students.loadStudentProfile(studentCode)
                        studentFirstName = Scripts.studentCred(
                                    studentCode, " ",
                                    "firstname")
                        studentLastName = Scripts.studentCred(
                                    studentCode, " ", "lastname")
                    }

    Timer {
        interval: 5000
        running:if(thisWindow.state === "Active") {true} else {false}
        repeat: true
        onTriggered: {
                    if(ticktock === 0) { ticktock = 1} else {ticktock = 0}
            Students.loadDay(d.getMonth(),d.getDate(),d.getDay(),studentCode)

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

    RightMenu {
        id: rightMenu
        anchors.right: parent.right
        anchors.top: topBar.bottom
        anchors.bottom: parent.bottom
        z: 5
        width: if (parent.width * 0.20 > 600) {
                   600
               } else {
                   parent.width * 0.20
               }
        state: "inActive"
        where: "studentInfo"
    }

    ScrollView {
        anchors.top: topBar.bottom
        anchors.topMargin: 5
        anchors.left: leftMenu.right
        width: if (rightMenu.state === "Active") {
                   thisWindow.width - leftMenu.width
               } else {
                   thisWindow.width - leftMenu.width
               }
        height: parent.height - topBar.height
        contentHeight: pageColumn.height + 40
        clip: true

        Column {
            id: pageColumn
            width: if (rightMenu.state === "Active") {
                       (thisWindow.width - leftMenu.width) * 0.98
                   } else {
                       (thisWindow.width - leftMenu.width) * 0.98
                   }

            spacing: 8

            Text {
                anchors.left: parent.left
                anchors.leftMargin: 10
                font.pointSize: 18
                text: qsTr("Next Up")
                font.bold: true
                width: parent.width * 0.5
                horizontalAlignment: Text.AlignLeft
            }
            Rectangle {
                color: seperatorColor
                width: parent.width * 0.98
                anchors.horizontalCenter: parent.horizontalCenter

                height: 2
            }

            Card {
                width: parent.width * 0.99
                height: thisWindow.height * 0.3
                anchors.horizontalCenter: parent.horizontalCenter
                property int timed:thisWindow.ticktock

                title : Courses.pullField("Title","course",Courses.lessonControlNext("courseNumber"))
                subjectNumber : Courses.pullField("Subject","course",Courses.lessonControlNext("courseNumber"))
                curtainColor : Courses.pullField("Color","subject",subjectNumber)
                unit : Courses.lessonControlNext("unitName")
                lesson : Courses.lessonControlNext("lessonName")
                lessonID : Courses.lessonControlNext("lessonNumber")

                onTimedChanged: {
                    title = Courses.pullField("Title","course",Courses.lessonControlNext("courseNumber"))
                    subjectNumber = Courses.pullField("Subject","course",Courses.lessonControlNext("courseNumber"))
                    curtainColor = Courses.pullField("Color","subject",subjectNumber)
                    unit = Courses.lessonControlNext("unitName")
                    lesson = Courses.lessonControlNext("lessonName")
                    lessonID = Courses.lessonControlNext("lessonNumber")
                    }
            }

            Row {
                width: parent.width * 0.98
                padding: 8
                Text {
                    font.pointSize: 18
                    text: qsTr("Today")
                    font.bold: true
                    width: parent.width * 0.5
                    horizontalAlignment: Text.AlignLeft
                }

                Text {
                    font.pointSize: 18
                    text: d.toLocaleDateString()
                    font.bold: true
                    width: parent.width * 0.5
                    horizontalAlignment: Text.AlignRight
                }
            }
            Rectangle {
                color: seperatorColor
                width: parent.width * 0.98
                anchors.horizontalCenter: parent.horizontalCenter

                height: 2
            }

            GridView {
                id: classGrid
                width: parent.width * 0.98
                anchors.horizontalCenter: parent.horizontalCenter
                height: contentHeight
                cellWidth: 405
                cellHeight: 250
                clip: true

                model: todaysClasses

                delegate: Item {
                    width: classGrid.cellWidth
                    height: classGrid.cellHeight
                    clip: true

                    Card {
                        width: parent.width * 0.96
                        height: parent.height * 0.96
                        anchors.centerIn: parent
                        curtainColor: classColor
                        title: classtitle
                        unit: unitName
                        lesson: lessonName
                    }
                }
            }

            Text {
                font.pointSize: 18
                text: qsTr("Continue Work")
                font.bold: true
                anchors.left: parent.left
                anchors.leftMargin: 10
            }
            Rectangle {
                color: seperatorColor
                width: parent.width * 0.98
                anchors.horizontalCenter: parent.horizontalCenter

                height: 2
            }

            GridView {
                id: preGrid
                width: parent.width * 0.98
                anchors.horizontalCenter: parent.horizontalCenter
                height: contentHeight
                cellWidth: 405
                cellHeight: 250
                clip: true

                model: continueLessons

                delegate: Item {
                    width: preGrid.cellWidth
                    height: preGrid.cellHeight
                    clip: true

                    Card {
                        width: parent.width * 0.96
                        height: parent.height * 0.96
                        anchors.centerIn: parent
                        curtainColor: classColor
                        title: classtitle
                        unit: unitName
                        lesson: lessonName
                    }
                }
            }
        }

    }

    ListModel {
        id: todaysClasses
    }

    ListModel {
        id:continueLessons
    }
}
