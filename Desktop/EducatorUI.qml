import QtQuick 2.11
import QtQuick.Controls 2.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0
//import QtQuick.Extras 1.4

import "./theme"
import "./plugins"

import "./course.js" as Courses
import "./network.js" as Network


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

                                            Network.checkOpenSeed(userid,schoolCode,"School")
                                            Network.checkOpenSeed(userid,userid,"Educator")
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

        Column {
            id:leftColumn
            anchors.top:parent.top
            anchors.topMargin: 20
            width:parent.width * 0.98
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: mainView.width * 0.01

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

        Column {
            anchors.horizontalCenter: parent.horizontalCenter
            width:parent.width * 0.95
            spacing: mainView.width * 0.005

        Row {
            width:leftMenu.width
            height: mainView * 0.04
        Text {
            text:qsTr("Course")
            font.bold: true
            width:parent.width * 0.70
        }
        Button {
            height:parent.height
            //width:parent.height
            text: "Add"
            background: ESTextField{}

            MouseArea {
                anchors.fill: parent
                onClicked: { cWizard.state = "Active"}
            }
        }

        }

        Rectangle {
            width:parent.width
            color:seperatorColor
            height: 2
        }

        ListView {
            width:parent.width
            height:contentHeight
            spacing: leftMenu.width * 0.01
            clip:true
            model: courseList


            delegate: Item {
                            width:parent.width
                            height:leftMenu.width * 0.3

                            Component.onCompleted: {
                               Network.checkOpenSeed(userid,cdate,"Courses")

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
                                        horizontalAlignment: Text.AlignHCenter
                                    }
                                }

                                Image {
                                    width:parent.height * 0.5
                                    height:parent.height * 0.5
                                    anchors.verticalCenter: parent.verticalCenter
                                    source:"./icons/Next.svg"
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

        }

        Column {
            anchors.horizontalCenter: parent.horizontalCenter
            width:parent.width * 0.95
            spacing: mainView.width * 0.005

        Row {
            width:leftMenu.width
            height: mainView * 0.04
        Text {
            text:qsTr("Students")
            font.bold: true
            width:parent.width * 0.70
        }
        Button {
            height:parent.height
            //width:parent.height
            text: "Add"
            background: ESTextField{}
            onClicked: {newStudent.state = "Active" }
        }

        }

        Rectangle {
            width:parent.width
            color:seperatorColor
            height: 2
        }

        ListView {
            width:parent.width
            height:contentHeight
            spacing: leftMenu.width * 0.01
            clip:true
            model: studentList


            delegate: Item {
                            width:parent.width
                            height:leftMenu.width * 0.3

                            Rectangle {
                                anchors.fill: parent
                                color:if(index % 2) {"#FFFFFF"} else {"#FAFAFA"}

                            }
                            Row {
                                width:parent.width
                                height:parent.height

                                /*Image {
                                    width:parent.height * 0.5
                                    height:parent.height * 0.5
                                    anchors.verticalCenter: parent.verticalCenter
                                    source:"./icons/minus.svg"
                                    fillMode: Image.PreserveAspectFit
                                } */

                                Item {
                                    width:parent.width - parent.height /2
                                    height:parent.height

                                    Text {
                                        anchors.centerIn: parent
                                        width:parent.width
                                        wrapMode: Text.WordWrap
                                        text:name
                                        horizontalAlignment: Text.AlignHCenter
                                    }
                                }

                                Image {
                                    width:parent.height * 0.5
                                    height:parent.height * 0.5
                                    anchors.verticalCenter: parent.verticalCenter
                                    source:"./icons/Next.svg"
                                    fillMode: Image.PreserveAspectFit

                                }



                            }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: {  rightMenu.state = "Active"
                                              course.state = "inActive"
                                              general.state = "inActive"
                                              student.state = "Active"

                                            }
                            }

                        }



        }

        }



        }



    }



    RightMenu {
        id:rightMenu
        anchors.right:parent.right
        anchors.top:parent.top
        anchors.bottom:parent.bottom
        width:if(parent.width * 0.20 > 600) {600} else {parent.width * 0.20}
    }


    ListModel {
        id:courseList

    }

    ListModel {
        id:studentList
    }

    GeneralInfoDashBoard {
        id:general
        anchors.right:rightMenu.left
        anchors.left:leftMenu.right
        anchors.verticalCenter: parent.verticalCenter
        height:parent.height
        state:"Active"
    }

    StudentDashBoard {
        id:student
        anchors.right:rightMenu.left
        anchors.left:leftMenu.right
        anchors.verticalCenter: parent.verticalCenter
        height:parent.height
        state:"inActive"
    }

    CourseDashBoard {
        id:course
        anchors.right:rightMenu.left
       // anchors.right:parent.right
        anchors.left:leftMenu.right
        anchors.verticalCenter: parent.verticalCenter
        height:parent.height
        state:"inActive"
        onStateChanged: if(state == "inActive") {Courses.loadCourses(userid)}
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
    }

}
