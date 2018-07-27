import QtQuick 2.11
import QtQuick.Controls 2.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0

import "../theme"
import "../plugins"
import "../Educator/scheduler.js" as Schedule
import "../Educator/course.js" as Courses
import "../Educator/students.js" as Students
import "steemit.js" as Steem
import "../plugins/markdown.js" as Marks
import "./network.js" as Network

Item {

    property string location: "Home"

    Rectangle {
        anchors.fill: parent
        color: menuColor
    }

    ESButton {
        id: logOut
        anchors.left: parent.left
        anchors.leftMargin: 8
        width: parent.height
        height: parent.height
        icon:  if (studentHome.state === "Active"
                       || educatorHome.state === "Active") {"/icons/close.svg"} else {"/icons/back.svg"}

        MouseArea {
            anchors.fill: parent
            onClicked: {
                if (studentHome.state === "Active"
                        || educatorHome.state === "Active") {
                    popUp.state = "Active"
                } else {
                    if(studentCode === 0) {
                        course.state = "inActive"
                        rightMenu.state = "inActive"
                        schedule.state = "inActive"
                        studentRoster.state = "inActive"
                        yourProfile.state = "inActive"
                        educatorHome.state === "Active"
                    } else {
                        lessonView.state = "inActive"
                        studentHome.state = "Active"
                    }

                }
            }
        }
    }

    Text {
        width: parent.width * 0.75
        anchors.left: logOut.right
        anchors.leftMargin: 8
        anchors.verticalCenter: parent.verticalCenter
        font.pointSize: 10
        font.bold: true
        text: schoolName.replace(/_/g, " ").trim() + " (" + location + ")"
        wrapMode: Text.WordWrap
        color: color1

        /* MouseArea {
            anchors.fill: parent
            onClicked: {
                student.state = "inActive"
                course.state = "inActive"
                general.state = "Active"
                rightMenu.state = "inActive"
                schedule.state = "inActive"
                studentRoster.state = "inActive"
                yourProfile.state = "inActive"
            }
        } */
    }
    Row {
        anchors.right: parent.right
        anchors.rightMargin: 10
        height: parent.height
        spacing: 3

        ESButton {
            width: parent.height
            height: parent.height
            icon: "/icons/message.svg"
        }

        ESButton {
            width: parent.height
            height: parent.height
            icon: "/icons/menu.svg"

            rotation: if (rightMenu.state == "Active") {
                          90
                      } else {
                          0
                      }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (rightMenu.state == "Active") {
                        rightMenu.state = "inActive"
                    } else {
                        rightMenu.state = "Active"
                    }
                }
            }
        }
    }
}
