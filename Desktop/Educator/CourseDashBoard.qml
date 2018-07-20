import QtQuick 2.11
import QtQuick.Controls 2.2

import "../theme"
import "../plugins"
import "../General"

import "./course.js" as Scripts

import "../General/network.js" as Network
import "../plugins/text.js" as Scrubber

Item {
    id: thisWindow

    property real coursenumber: 0
    property string courseName: "Course Name"
    property string courseAbout: "About"
    property string courseSubject: "Subject"
    property string courseDate: ""

    states: [

        State {
            name: "Active"
            PropertyChanges {

                target: thisWindow
                //opacity:1
                x: 0
            }
        },

        State {
            name: "inActive"
            PropertyChanges {

                target: thisWindow
                //opacity:0
                x: -parent.width
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
                properties: "x"
                duration: 100
                easing.type: Easing.InOutQuad
            }
        }
    ]

    state: "inActive"

    onStateChanged: if (state == "Active") {
                        Scripts.loadCourse(userID, coursenumber)
                        Scripts.loadUnits(userID, coursenumber)
                    } else {

                    }

    onCoursenumberChanged: if (state == "Active") {
                               Scripts.loadCourse(userID, coursenumber)
                               Scripts.loadUnits(userID, coursenumber)
                           } else {

                           }

    Rectangle {
        anchors.fill: parent
    }

    Text {
        id: title
        text: courseName
        anchors.top: parent.top
        anchors.left: backbutton.right
        anchors.margins: 20
        font.bold: true
        font.pointSize: 15

        Image {
            anchors.left: parent.right
            anchors.bottom: parent.bottom
            source: "/icons/edit-text.svg"
            width: parent.height * 0.5
            height: parent.height * 0.5
            fillMode: Image.PreserveAspectFit

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    editthis.field = "Title"
                    editthis.where = "course"
                    editthis.itemId = coursenumber
                    editthis.state = "Active"
                }
            }
        }
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
                general.state = "Active"
            }
        }
    }

    Button {
        anchors.verticalCenter: title.verticalCenter
        //anchors.top:parent.top
        anchors.right: parent.right
        anchors.margins: 20
        text: qsTr("Add Unit")
        background: ESTextField {
        }
        onClicked: {
            newUnit.state = "Active"
        }
    }

    Rectangle {
        anchors.top: title.bottom
        anchors.topMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width * 0.95
        height: 3
        color: seperatorColor
    }

    Item {
        anchors.top: title.bottom
        anchors.topMargin: 24
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width * 0.98
        // contentHeight: cColumn.height * 1.02
        clip: true
        Column {
            anchors.top: parent.top
            anchors.topMargin: 10
            id: cColumn
            width: parent.width
            spacing: mainView.width * 0.006

            ESborder {
                id:aboutBox
                anchors.horizontalCenter: parent.horizontalCenter
                width: thisWindow.width * 0.98
                height: about.height + 100
                Text {
                    id: about
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.margins: 20
                    text: courseAbout
                    wrapMode: Text.WordWrap
                    width: parent.width * 0.85
                }

                Text {
                    anchors.bottom: parent.bottom
                    anchors.right: parent.right
                    anchors.margins: 20
                    text: courseSubject
                }
                Text {
                    anchors.top: parent.top
                    anchors.right: parent.right
                    anchors.margins: 20
                    text: courseDate
                }
            }

            ListView {
                anchors.horizontalCenter: parent.horizontalCenter
                width: thisWindow.width * 0.98
                height: thisWindow.height - (topBar.height * 2.6) - aboutBox.height
                clip: true
                spacing: thisWindow.height * 0.02

                ScrollIndicator.vertical: ScrollIndicator { }


                model: unitList

                delegate: ESborder {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: thisWindow.width * 0.98
                    height: if (lessons.height > unitColumn.height) {
                                lessons.height * 1.05
                            } else {
                                unitColumn.height * 1.05
                            }

                    Component.onCompleted: {
                        Network.checkOpenSeed(userID, cdate, edate, "Units")
                    }
                    Row {
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        width: parent.width * 0.98
                        height: if (lessons.height > unitColumn.height) {
                                    lessons.height + 10
                                } else {
                                    unitColumn.height + 10
                                }

                        Column {
                            id: unitColumn

                            width: parent.width * 0.40
                            spacing: thisWindow.height * 0.02

                            Text {
                                padding: 10
                                text: Scrubber.recoverSpecial(name)
                                font.bold: true
                                font.pointSize: 12
                            }

                            Rectangle {

                                anchors.horizontalCenter: parent.horizontalCenter
                                width: parent.width * 0.95
                                height: 2
                                color: seperatorColor
                            }

                            MarkDown {

                                thedata: Scrubber.recoverSpecial(about)
                                //padding: 15
                                width: parent.width * 0.8
                                //wrapMode: Text.WordWrap
                            }
                        }

                        ListView {
                            id: lessons

                            height: contentHeight + 10
                            width: parent.width * 0.60
                            spacing: thisWindow.height * 0.02

                            model: CDBUnit {
                                thedate: cdate
                            }

                            delegate: ESborder {
                                width: thisWindow.width * 0.58
                                height: lessonColumn.height * 1.1

                                Component.onCompleted: {
                                    Network.checkOpenSeed(userID, cdate, edate,
                                                          "Lessons")
                                }

                                Column {
                                    id: lessonColumn
                                    width: parent.width * 0.99
                                    spacing: thisWindow.height * 0.01

                                    anchors.centerIn: parent

                                    Text {
                                        text: Scrubber.recoverSpecial(name)
                                        padding: 10
                                    }

                                    Rectangle {

                                        anchors.horizontalCenter: parent.horizontalCenter
                                        width: parent.width * 0.98
                                        height: 1
                                        color: seperatorColor
                                    }

                                    MarkDown {
                                        thedata: Scrubber.recoverSpecial(about)
                                        //padding: 10
                                        width: parent.width * 0.9
                                        //wrapMode: Text.WordWrap
                                    }
                                }
                            }
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        z: 2
                        onClicked: {
                            editUnit.unitNumber = cdate
                            editUnit.state = "Active"
                        }
                    }
                }
            }
        }
    }

    ListModel {
        id: unitList
    }

    UnitWizard {
        id: newUnit
        anchors.horizontalCenter: thisWindow.horizontalCenter
        anchors.verticalCenter: thisWindow.verticalCenter

        width: 800
        state: "inActive"

        onStateChanged: {
            Scripts.loadUnits(userID, coursenumber)
        }
    }

    UnitEditor {
        id: editUnit
        anchors.horizontalCenter: thisWindow.horizontalCenter
        anchors.verticalCenter: thisWindow.verticalCenter
        height: parent.height
        width: parent.width
        state: "inActive"
        onStateChanged: {
            Scripts.loadUnits(userID, coursenumber)
        }
    }

    FieldEdit {
        id: editthis
        width: parent.width
        height:parent.height
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        state: "inActive"

        onStateChanged: if (state == "inActive") {
                            Scripts.loadLesson(userID, lessonNumber)
                        }
    }
}
