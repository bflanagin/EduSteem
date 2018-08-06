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
    property string lessonName: ""
    property string lessonAuthor: ""
    property string lessonPublished: ""
    property string lessonAbout: ""
    property string lessonObjective: ""
    property string lessonResources: ""
    property string guidedQuestions: ""
    property string reviewQuestions: ""

    property int lessonDuration: 0
    property string lessonDate: ""

    property string lessonSequence: ""
    property string lessonSP: ""

    property string lessonUpdate: ""

    property string studentAnswers:""

    property string studentFirstName: ""
    property string studentLastName: ""
    property real  studentID: 0

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
                           Student.loadTask(studentID, lessonID)
                       }
    onStateChanged: if (state === "Active") {
                        Student.loadTask(studentID, lessonID)
                    }

    Rectangle {
        anchors.fill: parent
    }

    Item {
        id:titleBlock
        width:parent.width
        height:title.height + 40

    Text {
        id: title
        text: lessonName+" - "+studentFirstName+" "+studentLastName
        anchors.top: parent.top
        anchors.left: backbutton.right
        anchors.margins: 20
        font.bold: true
        font.pointSize: 15
        width:parent.width * 0.75
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

    }

    Item {
        id: mainArea
        anchors.top: titleBlock.bottom
        anchors.left: leftMenu.right
        anchors.margins: 4
        width: parent.width - leftMenu.width
        height: parent.height

        Row {
            anchors.top:parent.top
            anchors.topMargin: parent.height * 0.02
            width:parent.width * 0.98
            height:parent.height * 0.98

            Column {
                width:parent.width * 0.55
                spacing: 3

                Text {
                    text:qsTr("Assignment")
                    font.bold: true
                    anchors.left:parent.left
                    anchors.leftMargin: thisWindow.height * 0.01
                }

                Rectangle {
                    width:parent.width * 0.98
                    height:1
                    color:seperatorColor
                    anchors.horizontalCenter: parent.horizontalCenter
                }

        MarkDown {

            width:parent.width
            thedata: Scrubber.recoverSpecial(studentAnswers)
        }

            }

        Rectangle {
            width:1
            height:parent.height * 0.98
            color:seperatorColor
            anchors.verticalCenter: parent.verticalCenter
        }

        Column {
            width:parent.width * 0.50
            spacing: 3
            Text {
                text:qsTr("Notes:")
                font.bold: true
                anchors.left:parent.left
                anchors.leftMargin: thisWindow.height * 0.01
            }

            Rectangle {
                width:parent.width * 0.98
                height:1
                color:seperatorColor
                anchors.horizontalCenter: parent.horizontalCenter
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
                text: "Student: " + studentFirstName + " " + studentLastName
            }
            Text {
                text: "Date: " + d.toLocaleDateString()
            }
            Text {
                text: "Time: " + d.toLocaleTimeString()
            }
        }

        Text {
            id:messagesTop
             anchors.top: controlColumn.bottom
             anchors.topMargin: parent.height * 0.04
             anchors.left: parent.left
             anchors.leftMargin: parent.height * 0.01


            text: qsTr("Messages")

            Rectangle {
                anchors.top:parent.bottom
                anchors.topMargin: parent.height * 0.04
                anchors.horizontalCenter: controlArea.horizontalCenter
                width: controlArea.width * 0.97
                height: 2
                color: seperatorColor
            }
        }

        ListView {
            anchors.top:messagesTop.bottom
            anchors.topMargin: parent.height * 0.01
            anchors.bottomMargin: parent.height * 0.01
            anchors.bottom:actionButtons.top
            anchors.horizontalCenter: controlArea.horizontalCenter
            width:parent.width * 0.98
            clip:true
            model:messagesList

            delegate: ESborder {

                width:controlArea.width * 0.98
                height:thisWindow.height * 0.1

                Text {

                    anchors.centerIn: parent
                    text:message
                }
            }
        }

        Column {
            id:actionButtons
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height * 0.01
            width: parent.width
            spacing: parent.height * 0.01
            anchors.horizontalCenter: controlArea.horizontalCenter

            Button {
                id: breakbutton
                anchors.left: parent.left
                anchors.leftMargin: 10
                width:parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Revise")
                background: ESTextField {
                }

                onClicked: {
                    Student.updateTask(studentCode,lessonID,4,lessonUpdate)
                    controlArea.state = "inActive"
                    thisWindow.state = "inActive"
                    studentHome.state = "Active"
                }
            }

            Button {
                width: breakbutton.width
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Accepted")
                background: ESTextField {
                }

                onClicked: {
                    Student.updateTask(studentCode,lessonID,5,lessonUpdate)
                    controlArea.state = "inActive"
                    thisWindow.state = "inActive"
                     studentHome.state = "Active"
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
        width: mainArea.width * 0.30
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
        id:messagesList

        ListElement {
            message:"No Messages"
        }
    }
}
