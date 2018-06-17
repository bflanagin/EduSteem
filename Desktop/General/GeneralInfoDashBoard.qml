import QtQuick 2.11
import QtQuick.Controls 2.4
import "../theme"
import "../Educator/course.js" as Courses
import "../Educator/students.js" as Students

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

    onStateChanged: if (state == "Active") {
                        rightMenu.state = "inActive"
                    }

    ESborder {
        id: todayBlock
        width: parent.width
        height: 200

        Row {
            anchors.centerIn: parent
            width:parent.width * 0.98
            height:parent.height * 0.98

            Item {
                width:parent.width * 0.49
                height:parent.height

                Column {
                    anchors.centerIn: parent
                    width:parent.width * 0.98
                    height:parent.height * 0.98
                    spacing:6

               Text {
                    text:"Lesson:"
                    font.bold: true
                    font.pointSize: 12

                    }
                Text {
                    text:"Course:"
                    font.pointSize: 8
                }
                Text {
                    text:"Students:"
                    font.pointSize: 8
                }


                }


            }

            Rectangle {
                height:parent.height * 0.98
                anchors.verticalCenter: parent.verticalCenter
                width: 1
                color:seperatorColor
            }

            Item {
                width:parent.width * 0.49
                height:parent.height
                property real timeupdate: d.getTime()

                Timer {
                    running: if(thisWindow.state == "Active") {true} else {false}
                    repeat: true
                    interval: 1000
                    onTriggered: parent.timeupdate = parent.timeupdate + 1000
                }

                Text {
                    anchors.right:parent.right
                    anchors.top:parent.top
                    anchors.margins: 10
                    font.pointSize: 17
                    text:new Date(parent.timeupdate).toLocaleTimeString()
                }

                Text {
                    anchors.right:parent.right
                    anchors.bottom:parent.bottom
                    anchors.margins: 5
                    font.pointSize: 10
                    text:"Time In Lesson: Waiting to begin..."
                }

            }
        }
    }

    Flickable {
        id: flick
        anchors.top: todayBlock.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width * 0.98
        height: parent.height - todayBlock.height
        clip: true
        contentHeight: mainColumn.height + 50

        Column {
            id: mainColumn
            width: parent.width
            spacing: 10

            Text {
                anchors.left:parent.left
                anchors.margins: 10
                font.bold: true
                font.pointSize: 12
                text: qsTr("Students")
            }

            Rectangle {
                anchors.horizontalCenter: parent.horizontalCenter
                height: 3
                width: parent.width * 0.98
                color: seperatorColor
            }

            Grid {
                id:studentGrid
                width: parent.width
                spacing: 10
                //height: 310
                columns: 5
                Repeater {
                    id: theStudents
                    model: studentList

                    ESborder {
                       // width: parent.width / 5
                        width:title.width + 50
                        height:studentColumn.height + 10
                       // anchors.verticalCenter: parent.verticalCenter
                        state: "Active"
                        Column {
                            id:studentColumn
                            anchors.centerIn: parent
                            width:parent.width * 0.92

                            spacing: 5

                        Text {
                            id:title
                            text: name
                           // width:parent.width
                            wrapMode: Text.WordWrap
                            font.pointSize: 10
                            font.bold: true

                        }

                        Rectangle {
                            width:parent.width
                            height:1
                            color:seperatorColor
                        }

                        Text {
                            text: "Assignment:"
                            font.pointSize: 9
                            font.italic: true
                        }
                        ESSwitch {
                            id:finishedWork
                            font.pointSize: 8
                            text: "Finished:"

                        }
                        ESSwitch {
                            text: "Checked:"
                            font.pointSize: 8
                        }
                        ESSwitch {
                            text: "Approved:"
                            font.pointSize: 8

                        }

                        }
                    }
                }
            }

            Rectangle {
                anchors.horizontalCenter: parent.horizontalCenter
                height: 10
                width: parent.width * 0.98
                color: "Transparent"
            }

            Item {
                width:parent.width
                height:dAG.height
            Text {
                id:dAG
                anchors.left:parent.left
                anchors.margins: 10
                font.bold: true
                font.pointSize: 12
                text: switch (viewMode) {
                      case 0:
                          qsTr("Day At a Glance")
                          break
                      case 1:
                          qsTr("Week At a Glance")
                          break
                      case 2:
                          qsTr("Month At a Glance")
                          break
                      }
            }

            Button {
                anchors.right:parent.right
                anchors.margins: 10
                background: ESTextField{}
                height:dAG.height
                id:viewModeToggle
                text: switch (viewMode) {
                      case 0:
                          qsTr("This Week")
                          break
                      case 1:
                          qsTr("This Month")
                          break
                      case 2:
                          qsTr("Today")
                          break
                      }
                onClicked: if(viewMode < 2) {
                               viewMode = viewMode + 1
                           } else {
                               viewMode = 0
                           }
            }

            }

            Rectangle {
                anchors.horizontalCenter: parent.horizontalCenter
                height: 3
                width: parent.width * 0.98
                color: seperatorColor
            }
            ESborder {
                width:parent.width
                height:courseColumn.height + 30
            Column {
                    id:courseColumn
                    anchors.centerIn: parent
                width: parent.width
                //height: 200
                Repeater {
                    id: theThings
                    model: switch (viewMode) {
                           case 0:
                               6
                               break
                           case 1:
                               4
                               break
                           case 2:
                               30
                               break
                           }

                    Rectangle {
                        width: parent.width * 0.98
                        height: 80
                        anchors.horizontalCenter: parent.horizontalCenter
                        state: "Active"
                        color:if(index % 2) {"#FFFFFF"} else {"#FDFDFD"}
                        Column {
                            anchors.centerIn: parent
                            width:parent.width * 0.98
                            height:parent.height * 0.98
                        Text {
                            text: "Lesson"
                        }


                        }
                    }
                }
            }
            }
        }
    }
}
