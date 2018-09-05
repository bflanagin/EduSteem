import QtQuick 2.11
import QtQuick.Controls 2.2

import "../theme"
import "../plugins"
import "../Educator"
import "../Templates"

import "../Educator/course.js" as Scripts
import "../plugins/text.js" as Scrubber
import "../plugins/markdown.js" as MD


ESborder {
    id: thisWindow
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter
    height: cColumn.height + 50 + buttonRow.height

    property string field: ""
    property string where: ""
    property real itemId: 0
    property string existing: ""

    property var assType: ["None", "Journaling", "Writing", "Reading", "Web", "Video","Special","Offline Work"]
    property var assSelect: []

    property string preview: ""
    property string selected: "none"
    property var settings: []

    onStateChanged: if (state === "Active") {
                        existing = Scripts.pullField(field, where, itemId)
                    }

    Text {
        id: title
        anchors.top: parent.top
        anchors.topMargin: 10
        text: "Student Activity"
        font.bold: true
        font.pointSize: 18
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Rectangle {
        anchors.top: title.bottom
        height: 3
        width: thisWindow.width * 0.98
        anchors.horizontalCenter: thisWindow.horizontalCenter
        color: seperatorColor
    }

    Row {
        width: parent.width * 0.98
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: title.bottom
        anchors.topMargin: parent.height * 0.1
        anchors.bottom: buttonRow.top
        anchors.bottomMargin: parent.height * 0.1
        spacing: 5

        Flipable {
            id:previewSetupflip
            width: parent.width * 0.40
            height: parent.height

            transform: Rotation {
                    id: psrotation
                    origin.x: previewSetupflip.width/2
                    origin.y: previewSetupflip.height/2
                    axis.x: 0; axis.y: 1; axis.z: 0     // set axis.y to 1 to rotate around y-axis
                    angle: 0    // the default angle
                }

                states: State {
                    name: "back"
                    PropertyChanges { target: psrotation; angle: -180 }
                    when: selected == preview
                }

                transitions: Transition {
                    NumberAnimation { target: psrotation; property: "angle"; duration: 500 }
                }

            front: ESborder {
                id: assPreview
                width: parent.width
                height: parent.height

                Text {
                    id: assPreviewTitle
                    text: qsTr("Preview")
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    font.bold: true
                    anchors.top: parent.top
                    anchors.topMargin: parent.height * 0.01
                }

                Rectangle {
                    anchors.top: assPreviewTitle.bottom
                    anchors.topMargin: 5
                    anchors.horizontalCenter: assPreview.horizontalCenter
                    width: assPreview.width * 0.98
                    height: 3
                    color: seperatorColor
                }

                Item {
                    id: notemplate
                    visible: if (templatePicker.currentText !== "None" && preview !=="") {
                                 false
                             } else {
                                 true
                             }
                    width: parent.width * 0.50
                    height: parent.height * 0.50
                    anchors.centerIn: parent
                    opacity: 0.4

                    Image {
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                        width: parent.width
                        height: parent.width
                        antialiasing: true
                        source: "/icons/important.svg"
                    }

                    Text {
                        anchors.bottom: parent.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: qsTr("No Template selected")
                    }
                }

                Journal {
                    visible: if (templatePicker.currentText === "Journaling" && preview === "Simple") {
                                 true
                             } else {
                                 false
                             }
                    width: parent.width * 0.98
                    height: parent.height * 0.70
                    anchors.centerIn: parent
                    clip:true
                    enabled: false
                }

                Journal_Image {
                    visible: if (templatePicker.currentText === "Journaling" && preview === "Journal+Image") {
                                 true
                             } else {
                                 false
                             }
                    width: parent.width * 0.98
                    height: parent.height * 0.70
                    anchors.centerIn: parent
                    clip:true
                    enabled: false
                }

                Journal_Prompt {
                    visible: if (templatePicker.currentText === "Journaling" && preview === "Journal+Prompt") {
                                 true
                             } else {
                                 false
                             }
                    width: parent.width * 0.98
                    height: parent.height * 0.70
                    anchors.centerIn: parent
                    clip:true
                    enabled: false
                }

                Writing {
                    visible: if (templatePicker.currentText === "Writing" && preview === "Simple") {
                                 true
                             } else {
                                 false
                             }
                    width: parent.width * 0.98
                    height: parent.height * 0.70
                    anchors.centerIn: parent
                    clip:true
                    enabled: false
                }

                Writing_Prompt {
                    visible: if (templatePicker.currentText === "Writing" && preview === "Writing+Prompt") {
                                 true
                             } else {
                                 false
                             }
                    width: parent.width * 0.98
                    height: parent.height * 0.70
                    anchors.centerIn: parent
                    clip:true
                    enabled: false
                }

                Web {
                    visible: if (templatePicker.currentText === "Web" && preview === "Site Only") {
                                 true
                             } else {
                                 false
                             }
                    width: parent.width * 0.98
                    height: parent.height * 0.70
                    anchors.centerIn: parent
                    clip:true
                    enabled: false
                }

                Web_Notes {
                    visible: if (templatePicker.currentText === "Web" && preview === "Site+Notes") {
                                 true
                             } else {
                                 false
                             }
                    width: parent.width * 0.98
                    height: parent.height * 0.70
                    anchors.centerIn: parent
                    clip:true
                    enabled: false
                }

                Video {
                    visible: if (templatePicker.currentText === "Video" && preview === "Video Only") {
                                 true
                             } else {
                                 false
                             }
                    width: parent.width * 0.98
                    height: parent.height * 0.70
                    anchors.centerIn: parent
                    clip:true
                    enabled: false
                }

                Video_Notes {
                    visible: if (templatePicker.currentText === "Video" && preview === "Video+Notes") {
                                 true
                             } else {
                                 false
                             }
                    width: parent.width * 0.98
                    height: parent.height * 0.70
                    anchors.centerIn: parent
                    clip:true
                    enabled: false
                }
                Weekly_Review {
                    visible: if (templatePicker.currentText === "Special" && preview === "WeeklyReview") {
                                 true
                             } else {
                                 false
                             }
                    width: parent.width * 0.98
                    height: parent.height * 0.70
                    anchors.centerIn: parent
                    clip:true
                    enabled: false
                }


            }

            back: ESborder {
                id: assSettings
                width: parent.width
                height: parent.height

                Text {
                    id: assSetTitle
                    text: qsTr("Setup")
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    font.bold: true
                    anchors.top: parent.top
                    anchors.topMargin: parent.height * 0.01
                }

                Rectangle {
                    anchors.top: assSetTitle.bottom
                    anchors.topMargin: 5
                    anchors.horizontalCenter: assSettings.horizontalCenter
                    width: assSettings.width * 0.98
                    height: 3
                    color: seperatorColor
                }

                Journal_Settings {
                    visible: if (templatePicker.currentText === "Journaling" && preview === selected) {
                                 true
                             } else {
                                 false
                             }
                    width: parent.width * 0.98
                    height: parent.height * 0.70
                    anchors.centerIn: parent
                    clip:true
                    enabled: false
                }

                Video_Settings {
                    visible: if (templatePicker.currentText === "Video" && preview === selected) {
                                 true
                             } else {
                                 false
                             }
                    width: parent.width * 0.98
                    height: parent.height * 0.70
                    anchors.centerIn: parent
                    clip:true
                    enabled: false
                }

                Web_Settings {
                    visible: if (templatePicker.currentText === "Web" && preview === selected) {
                                 true
                             } else {
                                 false
                             }
                    width: parent.width * 0.98
                    height: parent.height * 0.70
                    anchors.centerIn: parent
                    clip:true
                    enabled: false
                }

                Writing_Settings {
                    visible: if (templatePicker.currentText === "Writing" && preview === selected) {
                                 true
                             } else {
                                 false
                             }
                    width: parent.width * 0.98
                    height: parent.height * 0.70
                    anchors.centerIn: parent
                    clip:true
                    enabled: false
                }


            }
        }

        Flipable {
            id:aboutInstructionflip
            width: parent.width * 0.38
            height: parent.height


            transform: Rotation {
                    id: rotation
                    origin.x: aboutInstructionflip.width/2
                    origin.y: aboutInstructionflip.height/2
                    axis.x: 0; axis.y: 1; axis.z: 0     // set axis.y to 1 to rotate around y-axis
                    angle: 0    // the default angle
                }

                states: State {
                    name: "back"
                    PropertyChanges { target: rotation; angle: 180 }
                    when: selected == preview
                }

                transitions: Transition {
                    NumberAnimation { target: rotation; property: "angle"; duration: 600 }
                }

            front: ESborder {
                id: aboutBlock
                width: parent.width
                height: parent.height
                clip: true

                Text {
                    id: aboutTitle
                    text: qsTr("About")
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    font.bold: true
                    anchors.top: parent.top
                    anchors.topMargin: parent.height * 0.01
                }

                Rectangle {
                    anchors.top: aboutTitle.bottom
                    anchors.topMargin: 5
                    anchors.horizontalCenter: aboutBlock.horizontalCenter
                    width: aboutBlock.width * 0.98
                    height: 3
                    color: seperatorColor
                }

                ScrollView {
                    anchors.top: aboutTitle.bottom
                    anchors.topMargin: 20
                    width: parent.width * 0.98
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 10
                    anchors.horizontalCenter: parent.horizontalCenter

                    Text {
                        id: about
                        width: aboutBlock.width * 0.98
                        height: aboutBlock.height * 0.98
                        padding:10
                        text:Scripts.assignmentInfo(templatePicker.currentText,preview)
                        wrapMode: Text.WordWrap
                    }
                }
            }

            back: ESborder {
                id: instructionBlock
                width: parent.width
                height: parent.height
                clip: true

                Text {
                    id: instructTitle
                    text: qsTr("Instructions")
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    font.bold: true
                    anchors.top: parent.top
                    anchors.topMargin: parent.height * 0.01
                }

                Rectangle {
                    anchors.top: instructTitle.bottom
                    anchors.topMargin: 5
                    anchors.horizontalCenter: instructionBlock.horizontalCenter
                    width: instructionBlock.width * 0.98
                    height: 3
                    color: seperatorColor
                }

                ScrollView {
                    anchors.top: instructTitle.bottom
                    anchors.topMargin: 20
                    width: parent.width * 0.98
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 10
                    anchors.horizontalCenter: parent.horizontalCenter
                    background: ESTextField {
                    }

                    TextArea {
                        id: instructions
                        width: instructionBlock.width * 0.98
                        height: instructionBlock.height * 0.98

                        wrapMode: Text.WordWrap
                    }
                }
            }
        }

        ESborder {
            id: templateBlock
            width: parent.width * 0.20
            height: parent.height
            clip: true
            state: "Active"

            Text {
                id: templateTitle
                text: qsTr("Activity Type")
                anchors.left: parent.left
                anchors.leftMargin: 5
                font.bold: true
                anchors.top: parent.top
                anchors.topMargin: parent.height * 0.01
            }

            Rectangle {
                anchors.top: templateTitle.bottom
                anchors.topMargin: 5
                anchors.horizontalCenter: templateBlock.horizontalCenter
                width: templateBlock.width * 0.98
                height: 3
                color: seperatorColor
            }

            ComboBox {
                id: templatePicker
                width: parent.width * 0.95
                anchors.top: templateTitle.bottom
                anchors.topMargin: 20
                anchors.horizontalCenter: parent.horizontalCenter
                model: assType

                background: ESTextField {
                }

                onCurrentTextChanged: Scripts.pullAssignmentTypes(currentText)
            }

            ListView {
                anchors.top: templatePicker.bottom
                anchors.bottom: parent.bottom
                width: parent.width * 0.98
                clip: true

                model: assSelect

                delegate: Rectangle {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width * 0.98
                    height: thisWindow.height * 0.1
                    color: if (index % 2 == 0) {
                               "#FFFFFF"
                           } else {
                               "#F0F0F0"
                           }
                    border.color: highLightColor1
                    border.width: 0

                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        text: assSelect[index]
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            parent.border.width = 1
                            preview = assSelect[index]
                        }
                        onClicked: {
                            parent.border.width = 2
                            selected = assSelect[index]
                        }
                        onExited: {
                            parent.border.width = 0
                        }
                    }
                }
            }
        }
    }

    Row {
        id: buttonRow
        anchors.bottomMargin: 10
        anchors.bottom: parent.bottom
        width: parent.width * 0.98
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: parent.width * 0.39

        Button {

            width: parent.width * 0.30
            background: ESTextField {
            }

            text: qsTr("Cancel")

            onClicked: {
                selected = "none"
                thisWindow.state = "inActive"
            }
        }

        Button {
            property string output: Scrubber.replaceSpecials(templatePicker.currentText)+"::"+
                                    Scrubber.replaceSpecials(selected)+"::"+Scrubber.replaceSpecials(instructions.text)+"::"+
                                    Scrubber.replaceSpecials(settings.toString())
            width: parent.width * 0.30
            background: ESTextField {
            }
            text: qsTr("Okay")

            onClicked: {
                Scripts.editField(field, where, itemId, output)
                thisWindow.state = "inActive"
            }
        }
    }
}
