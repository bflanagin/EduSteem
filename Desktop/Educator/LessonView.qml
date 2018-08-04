import QtQuick 2.11
import QtQuick.Controls 2.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0
import Qt.labs.calendar 1.0

import "../theme"
import "../plugins"
import "../General"
import "../Templates"

import "../plugins/text.js" as Scrubber
import "../Educator/course.js" as Courses
import "../General/network.js" as Network
import "../Student/student.js" as Student

Item {
    id: thisWindow

    property real lessonID: 0
    property string lessonTitle: ""
    property string lessonAuthor: ""
    property string lessonPublished: ""
    property string lessonAbout: ""
    property string lessonObjective: ""
    property string lessonResources: ""
    property string guidedQuestions: ""
    property string reviewQuestions: ""
    property string lessonSupplies:""
    property int lessonDuration: 0
    property string lessonDate: ""
    property string lessonGQ: ""
    property int lessonOrder: 0

    property string lessonSequence: "No Sequence"
    property string lessonSP: ""

    property string lessonUpdate: ""

    property string studentFirstName: ""
    property string studentLastName: ""

    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter

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
                duration: 400
                easing.type: Easing.InOutQuad
            }
        }
    ]

    state: "inActive"

    onLessonIDChanged: if (lessonID !== 0) {
                           Courses.loadLesson(userID, lessonID)
                       }
    onStateChanged: if (state === "Active") {
                        Courses.loadLesson(userID, lessonID)
                    }

    onLessonSequenceChanged: console.log("From Lesson View "+lessonSequence)

    Rectangle {
        anchors.fill: parent
    }

    Item {
        id: titleBlock
        width: parent.width * 0.76
        anchors.horizontalCenter: parent.horizontalCenter
        height: title.height + 40

        Text {
            id: title
            text: Scrubber.recoverSpecial(lessonTitle)
            anchors.top: parent.top
            anchors.left: backbutton.right
            anchors.margins: 20
            font.bold: true
            font.pointSize: 15
            width: parent.width * 0.75
            wrapMode: Text.WordWrap
        }

        CircleButton {
            id: backbutton
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.margins: 20
            height: title.height
            width: title.height

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    thisWindow.state = "inActive"
                }
            }
        }

        Text {
            anchors.top:title.bottom
            anchors.left:title.left
            anchors.margins: 5
            text:Scrubber.recoverSpecial(lessonAbout)
        }
    }

    Rectangle {
        anchors.top:titleBlock.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        height: 3
        color:seperatorColor
    }

    Item {
        id: mainArea
        anchors.top: titleBlock.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 10
        height: parent.height
        width: parent.width * 0.70

        Flickable {
            width: parent.width

            Column {
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width * 0.98
                spacing: thisWindow.height * 0.01


                Text {
                    text: qsTr("Supplies")
                    font.bold: true
                }

                MarkDown {
                    width: parent.width
                    thedata: Scrubber.recoverSpecial(lessonSupplies)
                }


                Text {
                    text: qsTr("Objective")
                    font.bold: true
                }

                MarkDown {
                    width: parent.width
                    thedata: Scrubber.recoverSpecial(lessonObjective)
                }

                Text {
                    text: qsTr("Sequence")
                    font.bold: true
                }
                MarkDown {
                    width: parent.width
                    thedata: Scrubber.recoverSpecial(lessonSequence)

                }
            }
        }
    }

    Item {
        id: controlArea
        anchors.top: parent.top
        anchors.topMargin: 4
        anchors.right: parent.right
        anchors.rightMargin: 8

        width: mainArea.width * 0.30
        height: parent.height
        z: if (instructionsArea.state === "Active"
                   || resourcesArea.state === "Active") {
               1
           } else {
               3
           }

        states: [

            State {
                name: "Active"
                PropertyChanges {
                    target: controlArea
                    anchors.rightMargin: 0
                }
            },
            State {
                name: "inActive"

                PropertyChanges {
                    target: controlArea
                    anchors.rightMargin: width * -0.99
                }
            }
        ]

        transitions: [

            Transition {
                from: "Active"
                to: "inActive"
                reversible: true

                NumberAnimation {
                    target: controlArea
                    property: "anchors.rightMargin"
                    duration: 200
                    easing.type: Easing.InOutQuad
                }
            }
        ]

        state: "inActive"

        VerticalTab {
            id: actTab
            label: "Activity"
            fillcolor: "white"
            anchors.right: parent.left
            anchors.top: parent.top
            anchors.topMargin: insTab.height + resTab.height + 30

            MouseArea {
                anchors.fill: parent
                onClicked: if (controlArea.state === "Active") {
                               controlArea.state = "inActive"
                           } else {
                               controlArea.state = "Active"
                           }
            }
        }

        ESborder {
            anchors.fill: parent
        }

        Column {
            id: controlColumn
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.margins: parent.width * 0.01
            width: parent.width * 0.98
            spacing: 10

            Text {
                font.bold: true
                font.pointSize: 12
                text: lessonName
            }
            Rectangle {

                anchors.horizontalCenter: controlArea.horizontalCenter
                width: controlArea.width * 0.97
                height: 2
                color: seperatorColor
            }

            Text {
                text: "Date: " + d.toLocaleDateString()
            }
            Text {
                text: "Time: " + d.toLocaleTimeString()
            }
        }

        Text {
            id: messagesTop
            anchors.top: controlColumn.bottom
            anchors.topMargin: parent.height * 0.04
            anchors.left: parent.left
            anchors.leftMargin: parent.height * 0.01

            text: qsTr("Messages")

            Rectangle {
                anchors.top: parent.bottom
                anchors.topMargin: parent.height * 0.04
                anchors.horizontalCenter: controlArea.horizontalCenter
                width: controlArea.width * 0.97
                height: 2
                color: seperatorColor
            }
        }

        ListView {
            anchors.top: messagesTop.bottom
            anchors.topMargin: parent.height * 0.01
            anchors.bottomMargin: parent.height * 0.01
            anchors.bottom: actionButtons.top
            anchors.horizontalCenter: controlArea.horizontalCenter
            width: parent.width * 0.98
            clip: true
            model: messagesList

            delegate: ESborder {

                width: controlArea.width * 0.98
                height: thisWindow.height * 0.1

                Text {

                    anchors.centerIn: parent
                    text: message
                }
            }
        }

        Column {
            id: actionButtons
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height * 0.01
            width: parent.width
            spacing: parent.height * 0.01
            anchors.horizontalCenter: controlArea.horizontalCenter

            Button {
                id: breakbutton
                anchors.left: parent.left
                anchors.leftMargin: 10
                width: parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Start")
                background: ESTextField {
                }

                onClicked: {
                    Courses.lessonControlUpdate(lessonID, 1)
                    controlArea.state = "inActive"
                    thisWindow.state = "inActive"

                }
            }

            Button {
                width: breakbutton.width
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Finish")
                background: ESTextField {
                }

                onClicked: {
                    Courses.lessonControlUpdate(lessonID, 2)
                    controlArea.state = "inActive"
                    thisWindow.state = "inActive"

                }
            }
        }
    }

    Item {
        id: instructionsArea
        anchors.top: parent.top
        anchors.topMargin: 4
        anchors.right: parent.right
        anchors.rightMargin: 8

        width: mainArea.width * 0.30
        height: parent.height
        z: 2

        states: [

            State {
                name: "Active"
                PropertyChanges {
                    target: instructionsArea
                    anchors.rightMargin: 0
                }
            },
            State {
                name: "inActive"

                PropertyChanges {
                    target: instructionsArea
                    anchors.rightMargin: width * -0.99
                }
            }
        ]

        transitions: [

            Transition {
                from: "Active"
                to: "inActive"
                reversible: true

                NumberAnimation {
                    target: instructionsArea
                    property: "anchors.rightMargin"
                    duration: 200
                    easing.type: Easing.InOutQuad
                }
            }
        ]

        state: "inActive"

        VerticalTab {
            id: insTab
            label: "Instructions"
            fillcolor: "white"
            anchors.right: parent.left
            anchors.top: parent.top
            anchors.topMargin: 10

            MouseArea {
                anchors.fill: parent
                onClicked: if (instructionsArea.state === "Active") {
                               instructionsArea.state = "inActive"
                           } else {
                               instructionsArea.state = "Active"
                           }
            }
        }

        ScrollView {
            anchors.right: parent.right
            width: parent.width
            height: parent.height

            ESborder {
                width: instructionsArea.width
                height: instructionsArea.height
                Column {
                    id: cColumn
                    width: mainArea.width * 0.31
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.margins: 10
                    spacing: 8
                    clip: true

                    Text {
                        text: qsTr("Instructions")
                        font.bold: true
                        font.pointSize: 12
                    }

                    Rectangle {

                        anchors.horizontalCenter: instructionsArea.horizontalCenter
                        width: instructionsArea.width * 0.95
                        height: 2
                        color: seperatorColor
                    }

                    MarkDown {
                        anchors.left: parent.left
                        anchors.margins: 8
                        width: parent.width
                        thedata: lessonSP.split("::")[2]
                    }
                }
            }
        }
    }

    Item {
        id: resourcesArea
        anchors.top: parent.top
        anchors.topMargin: 4
        anchors.right: parent.right
        anchors.rightMargin: 8
        z: if (instructionsArea.state === "Active") {
               1
           } else {
               2
           }
        width: mainArea.width * 0.40
        height: parent.height - topBar.height

        states: [

            State {
                name: "Active"
                PropertyChanges {
                    target: resourcesArea
                    anchors.rightMargin: 0
                }
            },
            State {
                name: "inActive"

                PropertyChanges {
                    target: resourcesArea
                    anchors.rightMargin: width * -0.99
                }
            }
        ]

        transitions: [

            Transition {
                from: "Active"
                to: "inActive"
                reversible: true

                NumberAnimation {
                    target: resourcesArea
                    property: "anchors.rightMargin"
                    duration: 200
                    easing.type: Easing.InOutQuad
                }
            }
        ]

        state: "inActive"

        VerticalTab {
            id: resTab
            label: "Resources"
            fillcolor: "white"
            anchors.right: parent.left
            anchors.top: parent.top
            anchors.topMargin: insTab.height + 20

            MouseArea {
                anchors.fill: parent
                onClicked: if (resourcesArea.state === "Active") {
                               resourcesArea.state = "inActive"
                           } else {
                               resourcesArea.state = "Active"
                           }
            }
        }



            ESborder {
                width: resourcesArea.width
                height: resourcesArea.height

                Column {
                    id: rColumn
                    width: resourcesArea.width
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.margins: 10
                    spacing: 8

                    Text {
                        text: qsTr("Resources")
                        font.bold: true
                        font.pointSize: 12
                    }

                    Rectangle {
                        anchors.horizontalCenter: resourcesArea.horizontalCenter
                        width: resourcesArea.width * 0.95
                        height: 2
                        color: seperatorColor
                    }

                    ResourceList {
                        anchors.left: parent.left
                        width: parent.width * 0.95
                        height: thisWindow.height * 0.65
                        thedata: Scrubber.recoverSpecial(lessonResources)
                    }
                }
            }

    }

    ListModel {
        id: messagesList

        ListElement {
            message: "No Messages"
        }
    }
}
