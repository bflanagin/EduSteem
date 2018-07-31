import QtQuick 2.11
import QtQuick.Controls 2.4
import "../theme"
import "../General"
import "../Educator/course.js" as Courses
import "../Educator/students.js" as Students
import "../Educator/scheduler.js" as Schedule
import "../General/general.js" as Scripts

Item {
    id: thisWindow

    property int viewMode: 0
    property var d: new Date()

    states: [

        State {
            name: "Active"
            PropertyChanges {

                target: thisWindow
                // opacity: 1
                anchors.horizontalCenterOffset: 0
            }
        },

        State {
            name: "inActive"
            PropertyChanges {

                target: thisWindow
                //opacity: 0
                anchors.horizontalCenterOffset: parent.width + 500
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
                properties: "opacity,anchors.horizontalCenterOffset"
                duration: 100
                easing.type: Easing.InOutQuad
            }
        }
    ]

    state: "inActive"

    onStateChanged: if (state === "Active") {
                        rightMenu.state = "inActive"
                        Schedule.load_Classes(d.getMonth(), d.getDay())

                    }



    Flickable {
        id: flick
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width * 0.98
        height: parent.height
        clip: true


        Column {
            id: todayBlock
            anchors.top:parent.top
            anchors.topMargin: thisWindow.height * 0.05
            width: parent.width
            spacing: 10

            Text {
                anchors.left: parent.left
                anchors.margins: 10
                font.bold: true
                font.pointSize: 12
                text: qsTr("Today:")
                width:parent.width

                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right:parent.right
                    anchors.rightMargin: 10
                    text:d.toLocaleDateString()
                    font.bold: true
                    font.pointSize: 12
                }
            }

            Rectangle {
                anchors.horizontalCenter: parent.horizontalCenter
                height: 3
                width: parent.width * 0.98
                color: seperatorColor
            }

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("No Classes Today")
                font.bold: true
                visible: if (dlist.count === 0) {
                             true
                         } else {
                             false
                         }
            }

            Grid {

                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width * 0.98
                spacing: 10
                columns: 5

                Repeater {
                    model:  DayList {
                            id:dlist
                        day: d.getDate()
                        month: d.getMonth()
                        weekday: d.getDay()
                        educator: "login"
                    }

                    ESborder {
                        width: thisWindow.width / 5.5
                        height: classColumn.height + thisWindow.height * 0.1
                        clickable: true
                        state: "Active"
                        Column {
                            id: classColumn
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top:parent.top

                            width: parent.width * 0.98

                            spacing: 5

                            Rectangle {
                                color:coursecolor
                                width:parent.width * 0.98
                                height:thisWindow.height * 0.05

                            Text {
                                anchors.left:parent.left
                                anchors.leftMargin: parent.height * 0.1
                                anchors.verticalCenter: parent.verticalCenter
                                text: name
                                wrapMode: Text.WordWrap
                                width:parent.width * 0.98
                                font.pointSize: 10
                                font.bold: true
                                color:"white"
                            }

                            }
                        }
                    }
                }
            }
        }


        Column {
            id: turnedinBlock
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top:todayBlock.bottom
            anchors.topMargin: thisWindow.height * 0.05
            width: parent.width
            spacing: 10

            Text {
                anchors.left: parent.left
                anchors.margins: 10
                font.bold: true
                font.pointSize: 12
                text: qsTr("Turned In:")


            }

            Rectangle {
                anchors.horizontalCenter: parent.horizontalCenter
                height: 3
                width: parent.width * 0.98
                color: seperatorColor
            }

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("No assignments to check")
                font.bold: true
                visible: if (turnedin.count === 0) {
                             true
                         } else {
                             false
                         }
            }

            Grid {
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width * 0.98
                spacing: 10
                columns: 5

                Repeater {
                    model: turnedin

                    ESborder {
                        width: thisWindow.width / 5
                        height: checkColumn.height + startededdate.height + finisheddate.height + thisWindow.height * 0.05
                        clickable: true
                        state: "Active"
                        Column {
                            id: checkColumn
                            anchors.top:parent.top
                            anchors.topMargin: parent.height * 0.02
                            anchors.left:parent.left
                            width: parent.width* 0.95
                            anchors.horizontalCenter: parent.horizontalCenter
                            clip:true

                            spacing: thisWindow.height * 0.02

                            Rectangle {
                                anchors.horizontalCenter: parent.horizontalCenter
                                width:parent.width * 0.99
                                height:lessonTitle.height + thisWindow.height * 0.03
                                color:thecolor

                            Text {
                                id:lessonTitle
                                text: name
                                anchors.left: parent.left
                                anchors.leftMargin: parent.width * 0.02
                                width:parent.width
                                wrapMode: Text.WordWrap
                                font.pointSize: 12
                                font.bold: true
                                anchors.verticalCenter: parent.verticalCenter
                                color:"white"
                            }

                            }


                            Text {
                                anchors.left:parent.left
                                anchors.leftMargin: parent.width * 0.03
                                text: studentName
                                width:parent.width
                                wrapMode: Text.WordWrap
                                font.pointSize: 13
                                font.bold: true

                            }

                        }

                        Text {
                            id:startededdate
                            anchors.bottom: finisheddate.top
                            anchors.right:parent.right
                            anchors.margins: parent.width * 0.01
                            text: qsTr("Started: ")+cdate
                            wrapMode: Text.WordWrap
                            width:parent.width
                            horizontalAlignment: Text.AlignRight
                            font.pointSize: 7

                        }

                        Text {
                            id:finisheddate
                            anchors.bottom: parent.bottom
                            anchors.right:parent.right
                            anchors.margins: parent.width * 0.01
                            text: qsTr("Finished: ")+edate
                            wrapMode: Text.WordWrap
                            width:parent.width
                            horizontalAlignment: Text.AlignRight
                            font.pointSize: 7

                        }

                        MouseArea {
                            anchors.fill:parent
                            onClicked: {
                                        reviewView.studentFirstName = studentName.split(" ")[0]
                                        reviewView.studentLastName = studentName.split(" ")[1]
                                        reviewView.lessonID = lessonid
                                        reviewView.lessonName = name
                                        reviewView.state = "Active"


                                        }
                        }

                    }
                }
            }
        }

        Column {
            id: conversationBlock
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top:turnedinBlock.bottom
            anchors.topMargin: thisWindow.height * 0.05
            width: parent.width
            spacing: 10

            Text {
                anchors.left: parent.left
                anchors.margins: 10
                font.bold: true
                font.pointSize: 12
                text: qsTr("Active Discussion:")
            }

            Rectangle {
                anchors.horizontalCenter: parent.horizontalCenter
                height: 3
                width: parent.width * 0.98
                color: seperatorColor
            }

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("No assignments in discussion")
                font.bold: true
                visible: if (discussed.count === 0) {
                             true
                         } else {
                             false
                         }
            }

            Grid {
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width * 0.98
                spacing: 10
                columns: 5

                Repeater {
                    model: discussed

                    ESborder {
                        width: thisWindow.width / 5
                        height: messageColumn.height + thisWindow.height * 0.1

                        state: "Active"
                        Column {
                            id: messageColumn
                            anchors.centerIn: parent
                            width: parent.width * 0.92

                            spacing: 5

                            Text {

                                text: name
                                wrapMode: Text.WordWrap
                                font.pointSize: 10
                                font.bold: true
                            }

                            Rectangle {
                                width: parent.width
                                height: 1
                                color: seperatorColor
                            }
                        }
                    }
                }
            }
        }
    }
}
