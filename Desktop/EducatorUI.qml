import QtQuick 2.11
import QtQuick.Controls 2.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0
//import QtQuick.Extras 1.4

import "./theme"
import "./plugins"


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
                font.pointSize: 12
                font.bold: true
                text: "School Name"
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
                text: "Educator"
            }

            Rectangle {
                width:parent.width
                color:seperatorColor
                height: 2
            }

        Column {
            Text {
                font.pointSize: 6
                text: "Courses: "+courseList.count
            }
            Text {
                font.pointSize: 6
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
                onClicked: cWizard.state = "Active"
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
                                onClicked: { rightMenu.state = "inActive"
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



    ESborder {
        id:rightMenu

        states: [

                State {
                    name:"Active"

                    PropertyChanges {
                        target: rightMenu
                        anchors.rightMargin: 0
                    }
            },

            State {
                name:"inActive"

                PropertyChanges {
                    target: rightMenu
                    anchors.rightMargin: -1 * width
                }
        }


        ]

        transitions: [
            Transition {
                from: "inActive"
                to: "Active"
                reversible: true


                NumberAnimation {
                    target: rightMenu
                    property: "anchors.rightMargin"
                    duration: 200
                    easing.type: Easing.InOutQuad
                }

            }
        ]



state: "inActive"

        anchors.right:parent.right
        anchors.top:parent.top
        anchors.bottom:parent.bottom
        width:if(parent.width * 0.25 > 600) {600} else {parent.width * 0.25}


        Column {
            anchors.top:parent.top
            anchors.topMargin: 20
            width:parent.width * 0.98
            height:parent.width * 0.95
            spacing: rightMenu.width * 0.01

            Item {
                anchors.horizontalCenter: parent.horizontalCenter
                width:parent.width * 0.6
                height:parent.width * 0.6

           Dial {
               id:mainDial
                anchors.fill: parent
               from: 0
               to: 100
               value: 50
               visible: false


            Item {
                anchors.fill: parent

                Text {
                    width:parent.width * 0.8
                    horizontalAlignment: Text.AlignHCenter
                    anchors.centerIn: parent
                    font.pixelSize: parent.width * 0.2
                    text:mainDial.value+"%"
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: console.log("nope")
                }
            }
           }

           ColorOverlay {
                source:mainDial
                anchors.fill: mainDial
                color:seperatorColor

           }

            }

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text:qsTr("Week's Progress")
            }


            ListView {
                width:rightMenu.width * 0.95
                height:contentHeight
                anchors.horizontalCenter: parent.horizontalCenter
                clip:true
                spacing: rightMenu.width * 0.02
                model: 7

                delegate: Item {
                            width:rightMenu.width
                            height:rightMenu.width * 0.13

                            Rectangle {
                                anchors.fill:parent
                                color:if(index % 2) {"#FFFFFF"} else {"#FAFAFA"}
                            }

                            Rectangle {
                                anchors.bottom: parent.bottom
                                height:parent.height * 0.3
                                width: (parent.width * 0.5) * 0.80
                                color:seperatorColor

                                Text {
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.left:parent.left
                                    anchors.leftMargin: 5
                                    text:dayDial.value
                                    font.pixelSize: parent.height * 0.75

                                }
                            }

                        Text {
                            text:switch(index) {
                                 case 0: qsTr("Monday");break;
                                 case 1: qsTr("Tuesday");break;
                                 case 2: qsTr("Wednesday");break;
                                 case 3: qsTr("Thursday");break;
                                 case 4: qsTr("Friday");break;
                                 case 5: qsTr("Saturday");break;
                                 case 6: qsTr("Sunday");break;
                                 }
                                anchors.left: parent.left
                                anchors.top:parent.top
                                anchors.margins: parent.height * 0.1


                        }

                        Dial {
                            id:dayDial
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right:parent.right
                            anchors.rightMargin: parent.height * 0.5
                            width:parent.height * 0.8
                            height:parent.height * 0.8
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
                                 width:parent.width * 0.8
                                 horizontalAlignment: Text.AlignHCenter
                                 anchors.centerIn: parent
                                 font.pixelSize: parent.width * 0.2
                                 text:dayDial.value+"%"
                             }

                             MouseArea {
                                 anchors.fill: parent
                                 onClicked: console.log("nope")
                             }
                         }
                        }

                        ColorOverlay {
                             source:dayDial
                             anchors.fill: dayDial
                             color:seperatorColor
                             antialiasing: true
                        }

                }
            }

           }
    }


    ListModel {
        id:courseList

        ListElement {
            name:"Course 1"
        }

        ListElement {
            name:"Course 2"
        }
        ListElement {
            name:"Course 3"
        }

        ListElement {
            name:"Course 4"
        }
        ListElement {
            name:"Course 5"
        }



    }

    ListModel {
        id:studentList

        ListElement {
            name:"Student 1"
        }

        ListElement {
            name:"Student 2"
        }
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
        anchors.left:leftMenu.right
        anchors.verticalCenter: parent.verticalCenter
        height:parent.height
        state:"inActive"
    }

    CourseWizard {
        id:cWizard
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: leftMenu.width / 2
        state:"inActive"
        width: 500
        //height:300

    }

}
