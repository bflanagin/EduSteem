import QtQuick 2.11

import "../Plugins"
import "../Theme"

import "../Logic/course.js" as Courses

Item {
    id:thisWindow
    height:if(visible === false) {0} else {cColumn.height + 10}


    property var d: new Date()
    property real time: d.getTime()

    Timer {
        repeat: true
        running: true
        interval: 1000
        onTriggered: time = time + 1000
    }
    Column {
        id:cColumn
        anchors.top:parent.top
        anchors.topMargin: 10
        width:parent.width
        spacing:parent.width * 0.03

    ESborder {

        anchors.horizontalCenter: parent.horizontalCenter
        width:parent.width * 0.95
        height: parent.width * 0.3


        Text {
            property var thetime: new Date(time)
            text:thetime.toLocaleTimeString().split(" ")[0]
            color:selectedHighlightColor
            font.pixelSize: parent.height * 0.55
            anchors.centerIn: parent
        }

        Text {
            anchors.bottom:parent.bottom
            anchors.right:parent.right
            anchors.margins: 5
            color:selectedHighlightColor
            text:d.toLocaleDateString()
        }

    }

    Text {
        text:qsTr("Classes:")
        anchors.left:parent.left
        anchors.leftMargin: 10
        font.bold: true
        font.pointSize: 18
    }

    Rectangle {
        anchors.horizontalCenter: parent.horizontalCenter
        width:parent.width * 0.95
        height:2
        color:seperatorColor
    }

    ESborder {
                anchors.horizontalCenter: parent.horizontalCenter
                width:thisWindow.width * 0.95
                height:width * 0.5
            }

    Grid {
        width:parent.width * 0.95
        anchors.horizontalCenter: parent.horizontalCenter
        columns: 2
        spacing: 5
       Repeater {
           model:DayList {
                   id:dlist
               day: d.getDate()
               month: d.getMonth()
               weekday: d.getDay()
               educator: "login"
           }

        delegate: ESborder {
            width: thisWindow.width * 0.48
            height: classColumn.height + thisWindow.height * 0.03
            clickable: true
            state: "Active"
            Column {
                id: classColumn
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top:parent.top

                width: parent.width * 0.98

                spacing: parent.width * 0.03

                Rectangle {
                    anchors.horizontalCenter: parent.horizontalCenter
                    color:coursecolor
                    width:parent.width * 0.99
                    height:thisWindow.height * 0.05

                Text {
                    anchors.left:parent.left
                    anchors.leftMargin: parent.height * 0.1
                    anchors.verticalCenter: parent.verticalCenter
                    text: name
                    wrapMode: Text.WordWrap
                    width:parent.width * 0.98
                    font.pointSize: 12
                    font.bold: true
                    color:"white"
                }

                }
                Text {
                    anchors.left:parent.left
                    anchors.leftMargin: parent.width * 0.02
                    text:Courses.lessonControlINFO(coursenumber,"unitName","new")
                    width:parent.width
                    wrapMode: Text.WordWrap
                }

                Text {
                    anchors.left:parent.left
                    anchors.leftMargin: parent.width * 0.04
                    text:Courses.lessonControlINFO(coursenumber,"lessonName","new")
                    width:parent.width
                    wrapMode: Text.WordWrap
                }

            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    lessonControl.lessonID = Courses.lessonControlINFO(coursenumber,"lessonNumber","new")
                    lessonControl.state = "Active"
                }
            }
        }
       }
    }

    }



}
