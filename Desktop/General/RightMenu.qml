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
import "./general.js" as Scripts

import "../plugins/text.js" as Scrubber

Item {
    id: thisWindow

    states: [

        State {
            name: "Active"

            PropertyChanges {
                target: thisWindow
                anchors.rightMargin: 0
            }
        },

        State {
            name: "inActive"

            PropertyChanges {
                target: thisWindow
                anchors.rightMargin: -1 * thisWindow.width
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
                property: "anchors.rightMargin"
                duration: 100
                easing.type: Easing.InOutQuad
            }
        }
    ]

    state: "inActive"

    property string themonth: switch (selected_month) {
                              case 0:
                                  "January"
                                  break
                              case 1:
                                  "Febuary"
                                  break
                              case 2:
                                  "March"
                                  break
                              case 3:
                                  "April"
                                  break
                              case 4:
                                  "May"
                                  break
                              case 5:
                                  "June"
                                  break
                              case 6:
                                  "July"
                                  break
                              case 7:
                                  "August"
                                  break
                              case 8:
                                  "September"
                                  break
                              case 9:
                                  "October"
                                  break
                              case 10:
                                  "November"
                                  break
                              case 11:
                                  "December"
                                  break
                              }
    property real studentID: 0
    property string studentname: ""
    property int studentage: 0
    property string studentBday: "0"
    property string studentAbout: ""
    property string where: "default"

    property var profileAbout: []
    property var steemProfileInfo: []

    onStudentIDChanged: {
        Students.loadStudent(studentID)
        if (studentImage.flipped) {
            studentImage.flipped = false
        } else {
            studentImage.flipped = true
        }
    }

    ESborder {
        anchors.fill: parent
        state: "Active"

        Column {
            id: studentInfo
            visible: if (student.state == "Active"
                             || studentHome.state == "Active") {
                         true
                     } else {
                         false
                     }
            anchors.top: parent.top
            anchors.topMargin: 20
            width: parent.width * 0.98
            height: parent.width * 0.95
            spacing: thisWindow.width * 0.02

            Column {
                width: parent.width
                spacing: 5

                Text {
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    font.bold: true
                    font.pointSize: 16
                    text: if (studentCode !== 0) {
                              Scripts.studentCred(
                                          studentCode, " ",
                                          "firstname") + " " + Scripts.studentCred(
                                          studentCode, " ", "lastname")
                          } else {
                              "Unknown"
                          }
                }

                Text {
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    font.pointSize: 8
                    text: if (studentCode !== 0) {
                              "Age: " + Scripts.studentCred(studentCode,
                                                            " ", "age")
                          } else {
                              "Unknown"
                          }
                }

                Text {
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    font.pointSize: 8
                    text: if (studentCode !== 0) {
                              "Birthday: " + Scripts.studentCred(studentCode,
                                                                 " ", "bday")
                          } else {
                              "Unknown"
                          }
                }
            }

            Item {
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width * 0.6
                height: parent.width * 0.6

                Dial {
                    id: mainDial
                    anchors.fill: parent
                    from: 0
                    to: 100
                    value: 50
                    visible: false

                    Item {
                        anchors.fill: parent

                        Text {
                            width: parent.width * 0.8
                            horizontalAlignment: Text.AlignHCenter
                            anchors.centerIn: parent
                            font.pixelSize: parent.width * 0.2
                            text: mainDial.value + "%"
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: console.log("nope")
                        }
                    }
                }

                ColorOverlay {
                    source: mainDial
                    anchors.fill: mainDial
                    color: seperatorColor
                }
            }

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Week's Progress")
            }

            ListView {
                width: thisWindow.width * 0.95
                height: contentHeight
                anchors.horizontalCenter: parent.horizontalCenter
                clip: true
                spacing: thisWindow.width * 0.02
                model: 7

                delegate: Item {
                    width: thisWindow.width
                    height: thisWindow.width * 0.13

                    Rectangle {
                        anchors.fill: parent
                        color: if (index % 2) {
                                   "#FFFFFF"
                               } else {
                                   "#FAFAFA"
                               }
                    }

                    Rectangle {
                        anchors.bottom: parent.bottom
                        height: parent.height * 0.3
                        width: (parent.width * 0.5) * 0.80
                        color: seperatorColor

                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.leftMargin: 5
                            text: dayDial.value
                            font.pixelSize: parent.height * 0.75
                        }
                    }

                    Text {
                        text: switch (index) {
                              case 0:
                                  qsTr("Monday")
                                  break
                              case 1:
                                  qsTr("Tuesday")
                                  break
                              case 2:
                                  qsTr("Wednesday")
                                  break
                              case 3:
                                  qsTr("Thursday")
                                  break
                              case 4:
                                  qsTr("Friday")
                                  break
                              case 5:
                                  qsTr("Saturday")
                                  break
                              case 6:
                                  qsTr("Sunday")
                                  break
                              }
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.margins: parent.height * 0.1
                    }

                    Dial {
                        id: dayDial
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        anchors.rightMargin: parent.height * 0.5
                        width: parent.height * 0.8
                        height: parent.height * 0.8
                        from: 0
                        to: 100
                        value: 50
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
                                text: dayDial.value + "%"
                            }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: console.log("nope")
                            }
                        }
                    }

                    ColorOverlay {
                        source: dayDial
                        anchors.fill: dayDial
                        color: seperatorColor
                        antialiasing: true
                    }
                }
            }
        }

        Column {
            id: calendarInfo
            width: parent.width
            height: parent.height * 0.98
            anchors.centerIn: parent
            spacing: parent.width * 0.02
            visible: if (studentHome.state !== "Active"
                             && schedule.state == "Active") {
                         true
                     } else {
                         false
                     }

            Item {
                width: parent.width
                height: selectedday.height
                Text {
                    id: selectedday
                    text: themonth + " " + theday
                    width: parent.width - addclassbutton.width
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    wrapMode: Text.WordWrap
                    font.bold: true
                    font.pointSize: 12

                    onTextChanged: { console.log(theday)
                                    Schedule.load_Classes(selected_month, theday)
                                    }
                }

                ESButton {
                    id: addclassbutton
                    height: selectedday.height
                    width: height
                    anchors.right: parent.right
                    anchors.rightMargin: 5
                    anchors.verticalCenter: selectedday.verticalCenter
                    icon: "/icons/add.svg"
                    fillcolor: highLightColor1
                    MouseArea {
                        anchors.fill: parent

                        onClicked: {
                            classEdit.month = selected_month
                            classEdit.state = "Active"
                        }
                    }
                }
            }

            Rectangle {
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width * 0.95
                color: seperatorColor
                height: 3
            }

            Flickable {
                id: blocks
                clip: true
                width: parent.width * 0.99
                anchors.horizontalCenter: parent.horizontalCenter
                height: thisWindow.height * 0.93
                contentHeight: hours.height
                ScrollIndicator.vertical: ScrollIndicator {
                    visible: true
                }

                Column {
                    id: hours
                    anchors.top: parent.top
                    anchors.topMargin: 20
                    width: parent.width
                    spacing: 20
                    Repeater {
                        model: 24 - starttime

                        Rectangle {
                            width: parent.width * 0.98
                            anchors.right: parent.right

                            height: thisWindow.height * 0.15
                            color: if (index % 2) {
                                       "#FFFFFF"
                                   } else {
                                       "#F8F8F8"
                                   }

                            Text {
                                id: time
                                anchors.top: parent.top
                                anchors.topMargin: -23
                                anchors.right: parent.right
                                anchors.margins: 5
                                text: if (index + starttime < 12) {
                                          if (index + starttime == 0) {
                                              "12 AM"
                                          } else {
                                              index + starttime + " AM"
                                          }
                                      } else {
                                          if (index + starttime == 12) {
                                              index + starttime + " PM"
                                          } else {
                                              (index + starttime) - 12 + " PM"
                                          }
                                      }
                            }

                            Rectangle {
                                anchors.top: time.bottom
                                anchors.horizontalCenter: parent.horizontalCenter
                                width: parent.width * 0.95
                                color: seperatorColor
                                height: 1
                            }
                        }
                    }
                }

                Column {
                    id: classes
                    anchors.fill: parent
                    anchors.top: parent.top
                    anchors.topMargin: 20
                    spacing: 20
                    Repeater {
                        model: daysClasses
                        Item {
                            width: parent.width * 0.98
                            anchors.right: parent.right
                            height: if (listing.height > (thisWindow.height * 0.20)) {
                                        listing.height
                                    } else if (listing.height / (thisWindow.height * 0.20) > 0.60) {
                                        (thisWindow.height * 0.20)
                                    } else {
                                        listing.height + 15
                                    }
                            ESborder {
                                id: listing
                                clickable: true
                                width: parent.width * 0.80
                                anchors.left: parent.left
                                anchors.leftMargin: 2

                                height: if ((thisWindow.height * 0.15) * (duration / 60)
                                                < classname.height + 30) {
                                            classname.height + 30
                                        } else {
                                            (thisWindow.height * 0.15) * (duration / 60)
                                        }

                                Item {
                                    width: parent.width * 0.98
                                    height: parent.height * 0.98
                                    anchors.centerIn: parent
                                    clip: true

                                    Text {
                                        id: classname
                                        anchors.top: parent.top
                                        anchors.left: parent.left
                                        anchors.margins: 4
                                        text: Scrubber.recoverSpecial(name)
                                        horizontalAlignment: Text.AlignLeft
                                        width: parent.width * 0.65
                                        wrapMode: Text.WordWrap
                                    }
                                    Text {
                                        anchors.top: parent.top
                                        anchors.right: parent.right
                                        anchors.margins: 4
                                        text: if (duration >= 60) {
                                                  var time = duration / 60
                                                  if (time.toString().split(
                                                              ".").length === 2) {
                                                      time.toString().split(
                                                                  ".")[0] + ":"
                                                              + (6 * parseInt(
                                                                     time.toString(
                                                                         ).split(
                                                                         ".")[1]))
                                                  } else {
                                                      time + ":00"
                                                  }
                                              } else {
                                                  "0:" + duration
                                              }
                                        width: parent.width * 0.35
                                        horizontalAlignment: Text.AlignRight
                                        wrapMode: Text.WordWrap
                                    }

                                    Rectangle {
                                        anchors.top: classname.bottom
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        width: parent.width * 0.95
                                        color: seperatorColor
                                        height: 1
                                    }

                                    Column {
                                        anchors.topMargin: 10
                                        anchors.top: classname.bottom
                                        anchors.bottom: parent.bottom
                                        anchors.bottomMargin: 10
                                        clip: true
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        width: parent.width * 0.98
                                        spacing: 5
                                        Text {

                                            anchors.margins: 10
                                            text: Scrubber.recoverSpecial(unit)
                                        }

                                        Text {

                                            anchors.margins: 10
                                            text: Scrubber.recoverSpecial(about)
                                        }
                                    }
                                }
                                MouseArea {
                                    anchors.fill: parent
                                    hoverEnabled: true


                                    onClicked: {
                                        classEdit.classNum = cnum
                                        classEdit.edit = true
                                        classEdit.month = selected_month
                                        classEdit.state = "Active"


                                    }
                                }

                                Row {
                                    anchors.bottom:parent.bottom
                                    anchors.right:parent.right
                                    anchors.margins: 6
                                    height:thisWindow.height * 0.02
                                    spacing:thisWindow.height * 0.01

                                    CircleButton {
                                        height:parent.height
                                        width:parent.height
                                        icon:"/icons/minus.svg"

                                        MouseArea {
                                            anchors.fill: parent
                                            onClicked: {console.log(theday)
                                                        Schedule.move_Class(selected_month,fullday,"up")
                                                        Schedule.load_Classes(selected_month, theday)
                                                        }
                                        }
                                    }

                                    CircleButton {
                                        height:parent.height
                                        width:parent.height
                                        icon:"/icons/add.svg"

                                        MouseArea {
                                            anchors.fill: parent
                                            onClicked: {Schedule.move_Class(selected_month,fullday,"down")
                                                        Schedule.load_Classes(selected_month, theday)
                                            }
                                        }
                                    }




                                }
                            }
                        }
                    }
                }
            }
        }

        Column {
            id: studentAAG
            visible: if (studentHome.state !== "Active"
                             && studentRoster.state == "Active"
                             && studentID != 0) {
                         true
                     } else {
                         false
                     }
            anchors.fill: parent
            anchors.top: parent.top
            anchors.topMargin: 20
            spacing: 10

            Flipable {
                id: studentImage
                width: parent.width
                height: baseImage.height

                property bool flipped: false

                transform: Rotation {
                    id: rotation
                    origin.x: studentImage.width / 2
                    origin.y: studentImage.height / 2
                    axis.x: 0
                    axis.y: 1
                    axis.z: 0 // set axis.y to 1 to rotate around y-axis
                    angle: 0 // the default angle
                }

                states: State {
                    name: "back"
                    PropertyChanges {
                        target: rotation
                        angle: 180
                    }
                    when: studentImage.flipped
                }

                transitions: Transition {
                    NumberAnimation {
                        target: rotation
                        property: "angle"
                        duration: 500
                    }
                }

                front: Image {
                    id: baseImage
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width * 0.6
                    height: parent.width * 0.6
                    fillMode: Image.PreserveAspectCrop
                    source: "../icons/frontC.png"
                    visible: false
                }

                OpacityMask {
                    source: baseImage
                    anchors.fill: baseImage
                    maskSource: mask
                }

                back: Image {
                    id: baseImage1
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width * 0.6
                    height: parent.width * 0.6
                    fillMode: Image.PreserveAspectCrop
                    source: "../icons/frontC.png"
                    visible: false
                }

                OpacityMask {
                    source: baseImage
                    anchors.fill: baseImage
                    maskSource: mask
                }
            }

            Rectangle {
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width * 0.95
                color: seperatorColor
                height: 1
            }

            Text {
                anchors.left: parent.left
                anchors.leftMargin: 10
                font.bold: true
                text: studentname
            }
            Text {
                anchors.left: parent.left
                anchors.leftMargin: 10
                text: "Age: " + studentage
            }
            Text {
                anchors.left: parent.left
                anchors.leftMargin: 10
                text: "Birthday: " + studentBday
            }

            Rectangle {
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width * 0.95
                color: seperatorColor
                height: 1
            }
            Text {
                anchors.left: parent.left
                anchors.leftMargin: 10
                text: "About:"
            }
            Text {
                anchors.left: parent.left
                anchors.leftMargin: 10
                width: parent.width * 0.95
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignLeft
                text: studentAbout
            }
        }

        Column {
            id: eProfile
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width * 0.98
            visible: if (studentHome.state !== "Active"
                             && yourProfile.state == "Active") {
                         true
                     } else {
                         false
                     }
            onVisibleChanged: if (yourProfile.state == "Active") {
                                  Steem.get_follow(steemAccount)
                                  Steem.get_info(steemAccount)
                              }
            spacing: 10

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                font.bold: true
                text: "Steem Account"
                font.pointSize: 14
            }

            Item {
                id: imageBlock
                width: parent.width * 0.7
                height: parent.width * 0.7
                anchors.horizontalCenter: parent.horizontalCenter
                Image {
                    id: profileImage
                    anchors.centerIn: parent
                    width: parent.width * 0.87
                    height: width
                    fillMode: Image.PreserveAspectCrop
                    visible: false
                    z: 1
                    source: steemProfileInfo[4].split('":"')[1].replace(/"/g,
                                                                        '')

                    Image {

                        anchors.fill: parent
                        fillMode: Image.PreserveAspectCrop
                        z: -1
                        source: "../icons/frontC.png"
                    }
                }
                OpacityMask {
                    source: profileImage
                    anchors.fill: profileImage
                    maskSource: mask
                }
            }

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: steemProfileInfo[0].split('":"')[1].replace(/"/g, '')
                font.bold: true
                font.pointSize: 10
            }

            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width * 0.98
                spacing: 5

                Text {
                    horizontalAlignment: Text.AlignLeft
                    font.pointSize: 6
                    width: parent.width * 0.48
                    text: qsTr("Followers: ") + profileAbout[2].split(":")[1]
                }

                Text {
                    horizontalAlignment: Text.AlignRight
                    font.pointSize: 6
                    text: qsTr("Following: ") + profileAbout[3].split(
                              ":")[1].replace("}", "")
                    width: parent.width * 0.48
                }
            }

            Rectangle {
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width * 0.95
                color: seperatorColor
                height: 1
            }

            Text {
                text: qsTr("About:")
                font.bold: true
                anchors.left: parent.left
            }

            Text {
                text: steemProfileInfo[3].split(":")[1].replace(/"/g, '')
                width: parent.width * 0.98
                wrapMode: Text.WordWrap
                anchors.horizontalCenter: parent.horizontalCenter
                horizontalAlignment: Text.AlignLeft
            }
        }

        Item {
            anchors.fill: parent
            visible: if (studentHome.state == "Active"
                             || yourProfile.state == "Active"
                             && steemAccount !== "") {
                         false
                     } else if (yourProfile.state == "inActive") {
                         false
                     } else {
                         true
                     }

            Rectangle {
                color: "white"
                width: parent.width * 0.98
                height: parent.height * 0.98
                anchors.centerIn: parent
            }
            Image {
                source: "../img/steem.png"
                height: parent.width * 0.7
                width: parent.width * 0.7
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -100

                Text {
                    anchors.top: parent.bottom
                    anchors.topMargin: 20
                    text: qsTr("No Steem account found")
                    font.pointSize: 10
                    font.bold: true
                    width: parent.width
                    wrapMode: Text.WordWrap
                    horizontalAlignment: Text.AlignHCenter
                }
            }
        }
    }

    ListModel {
        id: daysClasses

        ListElement {
            name: "Class 1"
            duration: 45
            unit: "Unit Number"
            about: "About the class"
        }

        ListElement {
            name: "Class 2"
            duration: 60
            unit: "Unit Number"
            about: "About the class"
        }
        ListElement {
            name: "Class 3"
            duration: 10
            unit: "Unit Number"
            about: "About the class"
        }
        ListElement {
            name: "Class 4"
            duration: 120
            unit: "Unit Number"
            about: "About the class"
        }
    }
}
