import QtQuick 2.11
import QtQuick.Window 2.11
import QtQuick.Window 2.3
import QtQuick.Controls 2.2
import QtMultimedia 5.9
import QtQuick.Controls.Material 2.2

import "../Theme"
import "../Plugins"
import "../Logic/course.js" as Course
import "../Logic/general.js" as Scripts

Item {
id: thisWindow
width: parent.width
height:parent.height


property real lessonID: 0


states: [

    State {
        name: "Active"
        PropertyChanges {
            target: thisWindow
            anchors.leftMargin: 0
        }
    },

    State {
        name: "inActive"
        PropertyChanges {
            target: thisWindow
            anchors.leftMargin: width * -1
        }
    }
]

transitions: [
    Transition {
        from: "Active"
        to: "inActive"
        reversible: true

        NumberAnimation {
            target: thisWindow
            property: "anchors.leftMargin"
            duration: 200
            easing.type: Easing.InOutQuad
        }
    }
]

state: "inActive"

onStateChanged: if (state === "Active") {
                    //Scripts.loadStudent(studentId)
                }

Rectangle {
    anchors.fill: parent
    color: "#F9F9F9"
}

LessonView {
    id:lessonView
    anchors.top:parent.top
    anchors.bottom:footer.top
    width:parent.width
    visible: false


}

GQView {
    id:gqView
    anchors.top:parent.top
    anchors.bottom:footer.top
    width:parent.width
    visible: false


}

ResourceView {
    id:resourceView
    anchors.top:parent.top
    anchors.bottom:footer.top
    width:parent.width
    visible: false



}

ClassControl {
    id:controlView
    anchors.top:parent.top
    anchors.bottom:footer.top
    width:parent.width
    visible: true

    }

ESborder {
    id: footer
    anchors.bottom: parent.bottom
    width: parent.width
    height: parent.height * 0.1
    z: 1

    Row {
        height: parent.height
        anchors.centerIn: parent
        spacing: thisWindow.width * 0.02

        ESButton {
            height: parent.height
            width: parent.height
            icon: "/Icons/back.svg"
            label: "Home"
            fillcolor: if(thisWindow.visible !== true) {"white"} else {seperatorColor}

            Rectangle {
                anchors.centerIn: parent
                width:parent.width * 1.1
                height:width
                color:if(thisWindow.visible === true) {"white"} else {seperatorColor}
                z:-1
            }

            MouseArea {
                anchors.fill:parent
                onClicked: {    thisWindow.state = "inActive"

                            }
            }
        }

        ESButton {
            height: parent.height
            width: parent.height
            icon: "/Icons/bookmark"
            label: "Lesson"
            fillcolor: if(lessonView.visible === true) {"white"} else {seperatorColor}
            Rectangle {
                anchors.centerIn: parent
                width:parent.width * 1.1
                height:width
                color:if(lessonView.visible !== true) {"white"} else {seperatorColor}
                z:-1
            }

            MouseArea {
                anchors.fill:parent
                onClicked: {
                            Scripts.deselectAll()
                            lessonView.visible = true
                            }
            }
        }

        ESButton {
            height: parent.height
            width: parent.height
            icon: "/Icons/help.svg"
            label: "Guided Questions"
            fillcolor: if(gqView.visible === true) {"white"} else {seperatorColor}

            Rectangle {
                anchors.centerIn: parent
                width:parent.width * 1.1
                height:width
                color:if(gqView.visible !== true) {"white"} else {seperatorColor}
                z:-1
            }

            MouseArea {
                anchors.fill:parent
                onClicked: {
                            Scripts.deselectAll()
                            gqView.visible = true
                            }
            }
        }

        ESButton {
            height: parent.height
            width: parent.height
            icon: "/Icons/star"
            label: "Resources"
            fillcolor: if(resourceView.visible === true) {"white"} else {seperatorColor}

            Rectangle {
                anchors.centerIn: parent
                width:parent.width * 1.1
                height:width
                color:if(resourceView.visible !== true) {"white"} else {seperatorColor}
                z:-1
            }

            MouseArea {
                anchors.fill:parent
                onClicked: {Scripts.deselectAll()
                            resourceView.visible = true
                            }
            }
        }

        ESButton {
            height: parent.height
            width: parent.height
            icon: "/Icons/desktop.svg"
            label: "Control"
            fillcolor: if(controlView.visible === true) {"white"} else {seperatorColor}

            Rectangle {
                anchors.centerIn: parent
                width:parent.width * 1.1
                height:width
                color:if(controlView.visible !== true) {"white"} else {seperatorColor}
                z:-1
            }

            MouseArea {
                anchors.fill:parent
                onClicked: {Scripts.deselectAll()
                            controlView.visible = true
                            }
            }

        }
    }
}


}
