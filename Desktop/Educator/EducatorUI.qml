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
    id:thisWindow

    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter

    states: [

            State {
                name:"Active"
                    PropertyChanges {

                        target:thisWindow
                        opacity:1
                        anchors.verticalCenterOffset: 0

                    }

                },

        State {
            name:"inActive"
                PropertyChanges {

                    target:thisWindow
                    opacity:0
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

    state:"inActive"


    onStateChanged: if(state == "Active") {Courses.loadCourses(userid)
                                           Students.loadStudents(schoolCode)

                                            Network.checkOpenSeed(userid,schoolCode,schoolEditDate,"School")
                                            Network.checkOpenSeed(userid,userid,userEditDate,"Educator")
                                            }


    Timer {
        id:checkforUpdates
        interval: 4000
        repeat: true
        onTriggered: if(state == "Active") {
            Network.sync("Courses",schoolCode)
            Network.sync("Units",schoolCode)
            Network.sync("Lessons",schoolCode)
            checkforUpdates.interval = 20000
        }
    }


    Rectangle {
        anchors.fill: parent
    }

    Item {
        id:middleArea
        anchors.left:leftMenu.right
        anchors.right:rightMenu.left
        anchors.top:parent.top
        anchors.bottom:parent.bottom


    }

    ESborder {
        id:leftMenu
        anchors.left:parent.left
        anchors.top:parent.top
        anchors.bottom:parent.bottom
        width:if(parent.width * 0.15 > 250) {250} else {parent.width * 0.15}
        clip:true
        z:5
        Column {
            id:leftColumn
            anchors.top:parent.top
            anchors.topMargin: 20
            anchors.bottom:monthselect.top
            anchors.bottomMargin: 3
            width:parent.width * 0.98
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: mainView.width * 0.01
            clip:true

        Column {
            id:titleArea

            anchors.horizontalCenter: parent.horizontalCenter
            width:parent.width * 0.95
            spacing: mainView.width * 0.005

            Text {
                width:parent.width
                font.pointSize: 9
                font.bold: true
                text: schoolName.replace(/_/g, " ").trim()
                wrapMode: Text.WordWrap



                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                                student.state = "inActive"
                                course.state = "inActive"
                                general.state = "Active"
                                rightMenu.state = "inActive"
                    }
                }
            }

            Text {
                text: userName
                font.pointSize: 8
                wrapMode: Text.WordWrap
                width:parent.width
            }

            Rectangle {
                width:parent.width
                color:seperatorColor
                height: 2
            }

        Column {
            Text {
                font.pointSize: 7
                text: "Courses: "+courseList.count
            }
            Text {
                font.pointSize: 7
                text: "Students: "+studentList.count
            }
        }

        }


        Rectangle {
                    width:parent.width
                    color:seperatorColor
                    height: 2
                }

        Text {
         text:qsTr("Educator")
         anchors.left: parent.left
         anchors.leftMargin: 3
         font.bold:true
         font.pointSize: 10
        }

        Column {
            anchors.horizontalCenter: parent.horizontalCenter
            width:parent.width * 0.98
            spacing: mainView.width * 0.005

        Item {

            width:leftMenu.width * 0.95
            height: mainView.height * 0.03

           // clip:true

            ESTextField {
                anchors.fill: parent
            }

        Text {
            anchors.left:parent.left
            anchors.leftMargin: 5
            text:qsTr("Course")
            anchors.verticalCenter: parent.verticalCenter
            font.bold: true
            width:parent.width * 0.70
        }

        Image {
            width:parent.height * 0.7
            height:parent.height * 0.7
            anchors.right:parent.right
            anchors.rightMargin: 5
            anchors.verticalCenter: parent.verticalCenter
            source:"/icons/add.svg"
            fillMode: Image.PreserveAspectFit
        }

        MouseArea {
            anchors.fill: parent
            onClicked: { cWizard.state = "Active"}
        }

        }

        Rectangle {
            width:parent.width
            color:seperatorColor
            height: 2
        }

        ListView {
            width:parent.width
            height:if(contentHeight < 210) {contentHeight} else {210}
            spacing: leftMenu.width * 0.01
            clip:true
            model: courseList
             ScrollIndicator.vertical: ScrollIndicator { }

            delegate: Item {
                            width:parent.width
                            height:leftMenu.width * 0.2

                            Component.onCompleted: {
                               Network.checkOpenSeed(userid,cdate,edate,"Courses")

                            }

                            Rectangle {
                                anchors.fill: parent
                                color:if(index % 2) {"#FFFFFF"} else {"#FAFAFA"}

                            }
                            Row {
                                width:parent.width
                                height:parent.height


                                Item {
                                    width:parent.width - parent.height /2
                                    height:parent.height

                                    Text {
                                        anchors.centerIn: parent
                                        width:parent.width
                                        wrapMode: Text.WordWrap
                                        text:name
                                        font.pointSize: 8
                                        horizontalAlignment: Text.AlignLeft
                                    }
                                }

                                Image {
                                    width:parent.height * 0.5
                                    height:parent.height * 0.5
                                    anchors.verticalCenter: parent.verticalCenter
                                    source:"/icons/Next.svg"
                                    fillMode: Image.PreserveAspectFit
                                }

                            }
                            MouseArea {
                                anchors.fill: parent
                                onClicked: { rightMenu.state = "Active"
                                             course.coursenumber = cdate
                                             course.state = "Active"

                                             general.state = "inActive"
                                             student.state = "inActive"
                                            }
                            }

                        }

        }

        Item {
            width:leftMenu.width * 0.95
            height: mainView.height * 0.03
            clip:true

            ESTextField {
                anchors.fill: parent
            }
        Text {
            anchors.left: parent.left
            anchors.leftMargin: 5
            text:qsTr("Activities")
            anchors.verticalCenter: parent.verticalCenter
            font.bold: true
            width:parent.width * 0.70
        }

        Image {
            width:parent.height * 0.7
            height:parent.height * 0.7
            anchors.right:parent.right
            anchors.rightMargin: 5
            anchors.verticalCenter: parent.verticalCenter
            source:"/icons/Next.svg"
            fillMode: Image.PreserveAspectFit
        }



        MouseArea {
            anchors.fill: parent
            //onClicked: {newStudent.state = "Active" }
        }

        }

        }

        Rectangle {
                    width:parent.width * 0.98
                    anchors.horizontalCenter: parent.horizontalCenter
                    color:seperatorColor
                    height: 2
                }

        Text {
         text:qsTr("Administration")
         anchors.left: parent.left
         anchors.leftMargin: 3
         font.bold:true
         font.pointSize: 10
        }

        Column {
            anchors.horizontalCenter: parent.horizontalCenter
            width:parent.width * 0.98
            spacing: mainView.width * 0.005

        Item {
            width:leftMenu.width * 0.95
            height: mainView.height * 0.03
            clip:true

            ESTextField {
                anchors.fill: parent
            }
        Text {
            anchors.left: parent.left
            anchors.leftMargin: 5
            text:qsTr("Students")
            anchors.verticalCenter: parent.verticalCenter
            font.bold: true
            width:parent.width * 0.70
        }

        Image {
            width:parent.height * 0.7
            height:parent.height * 0.7
            anchors.right:parent.right
            anchors.rightMargin: 5
            anchors.verticalCenter: parent.verticalCenter
            source:"/icons/Next.svg"
            fillMode: Image.PreserveAspectFit
        }



        MouseArea {
            anchors.fill: parent
            onClicked: {newStudent.state = "Active" }
        }

        }

        Item {
            width:leftMenu.width * 0.95
            height: mainView.height * 0.03
            clip:true

            ESTextField {
                anchors.fill: parent
            }
        Text {
            anchors.left: parent.left
            anchors.leftMargin: 5
            text:qsTr("Schedule")
            anchors.verticalCenter: parent.verticalCenter
            font.bold: true
            width:parent.width * 0.70
        }

        Image {
            width:parent.height * 0.7
            height:parent.height * 0.7
            anchors.right:parent.right
            anchors.rightMargin: 5
            anchors.verticalCenter: parent.verticalCenter
            source:"/icons/Next.svg"
            fillMode: Image.PreserveAspectFit
        }



        MouseArea {
            anchors.fill: parent
            onClicked: {schedule.state = "Active"
                            rightMenu.state = "Active"
            }
        }

        }


        }



        }

        SpinBox {
            id: monthselect
            from: 0
            to: 11
            value: d.getMonth()
            anchors.bottom:dayselect.top
            anchors.horizontalCenter: parent.horizontalCenter

            contentItem: Label {
                text: switch (parent.value) {
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

                width: parent.width
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                color: "black"
                font.pointSize: 8
            }

            down.indicator: Rectangle {
                width: parent.height / 2
                height: parent.height / 2
                radius: width / 2
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                color: seperatorColor


                Image {
                    id: d1
                    source: "/icons/minus.svg"
                    anchors.centerIn: parent
                    fillMode: Image.PreserveAspectFit
                    width: parent.width * 0.65
                }

                ColorOverlay {
                    source: d1
                    color: "white"
                    anchors.fill: d1
                }
            }

            up.indicator: Rectangle {
                width: parent.height / 2
                height: parent.height / 2
                radius: width / 2
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                color: seperatorColor


                Image {
                    id: u1
                    source: "/icons/add.svg"
                    anchors.centerIn: parent
                    fillMode: Image.PreserveAspectFit
                    width: parent.width * 0.65
                }

                ColorOverlay {
                    source: u1
                    color: "white"
                    anchors.fill: u1
                }
            }
        }

        Item {
            id: dayselect
            width: parent.width * 0.98
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom:parent.bottom
            anchors.bottomMargin: 10
            height: grid.height + dow.height

            DayOfWeekRow {
                id: dow
                locale: grid.locale
                width: grid.width
                anchors.bottom: grid.top
                delegate: Text {

                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    //font: parent.font
                    text: model.shortName
                    color: "black"
                    font.pointSize: 6
                }
            }
            MonthGrid {
                id: grid
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width * 0.98
                month: monthselect.value

                title: month

                locale: Qt.locale("en_US")

                delegate: Rectangle {
                    width: 20
                    height: 20
                    radius: width / 2
                    color: model.day === theday ? seperatorColor : "white"
                    opacity: model.month === monthselect.value ? 1 : 0
                    Text {
                        anchors.centerIn: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        text: model.day
                        color: model.day === theday ? "white" : "black"
                        font.pointSize: 6
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            theday = model.day
                        }
                    }
                }
            }
        }

    Text {
        anchors.bottom:parent.bottom
        anchors.left:parent.left
        anchors.margins: 10
        text:schoolCode
        opacity: 0.5
        font.pointSize: 5
    }

    }


    ListModel {
        id:courseList

    }

    ListModel {
        id:studentList
    }

    GeneralInfoDashBoard {
        id:general
        anchors.right:if(rightMenu.state == "Active") {rightMenu.left} else {parent.right}
        anchors.left:leftMenu.right
        anchors.verticalCenter: parent.verticalCenter
        height:parent.height
        state:"Active"
    }

    StudentDashBoard {
        id:student

        width:parent.width - (leftMenu.width + rightMenu.width)
        anchors.verticalCenter: parent.verticalCenter
        height:parent.height
        state:"inActive"
    }

    CourseDashBoard {
        id:course

        width:parent.width - (leftMenu.width + rightMenu.width)
        anchors.verticalCenter: parent.verticalCenter
        height:parent.height
        state:"inActive"
        onStateChanged: if(state == "inActive") {Courses.loadCourses(userid)}
    }

    Scheduler {
        id:schedule
        width:parent.width - (leftMenu.width + rightMenu.width)
        anchors.verticalCenter: parent.verticalCenter
        height:parent.height
        state:"inActive"
        //onStateChanged: if(state == "inActive") {} else {rightMenu.state = "Active"}
    }

    RightMenu {
        id:rightMenu
        anchors.right:parent.right
        anchors.top:parent.top
        anchors.bottom:parent.bottom
        width:if(parent.width * 0.20 > 600) {600} else {parent.width * 0.20}
        state:"inActive"
    }

    CourseWizard {
        id:cWizard
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: leftMenu.width / 2
        state:"inActive"
        width: 800
        //height:300

        onStateChanged: if(state == "inActive") {Courses.loadCourses(userid)}

    }

    NewStudentAccount {
        id:newStudent
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: leftMenu.width / 2
        state:"inActive"
        width: 800

        onStateChanged: if(state == "inActive") {Students.loadStudents(schoolCode)}
    }

    ClassEdit {
        id:classEdit
        width: 800
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: leftMenu.width / 2
        state:"inActive"
    }



}
