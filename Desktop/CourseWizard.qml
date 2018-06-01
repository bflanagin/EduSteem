import QtQuick 2.11
import QtQuick.Controls 2.2

import "./theme"
import "./plugins"

ESborder {
    id:thisWindow
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter
    height: cColumn.height * 1.1

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
                duration: 550
                easing.type: Easing.InOutElastic
            }
        }
    ]

    state:"inActive"

 Column {
     id:cColumn
     anchors.centerIn: parent
     width:parent.width * 0.98
     //height: parent.height * 0.95
     spacing: thisWindow.width * 0.04
    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        text:"Course"
        font.pointSize: 18
    }

    Rectangle {
        width:parent.width * 0.99
        anchors.horizontalCenter: parent.horizontalCenter
        height: 3
        color:seperatorColor
    }


    TextField {
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width * 0.95
        placeholderText: qsTr("Course Name")
        background:ESTextField {}
    }

    Row {
        width:parent.width * 0.98
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: parent.width * 0.02
    Text {
        text: "Subject"
        horizontalAlignment: Text.AlignHCenter
        width: parent.width * 0.49

    }

    Text {
        text: "Primary language"
        horizontalAlignment: Text.AlignHCenter
        width: parent.width * 0.49

    }

    }

    Row {
        width:parent.width * 0.98
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: parent.width * 0.02
    ComboBox {

        width: parent.width * 0.49
        model: courses

        background: ESTextField{}
    }

    ComboBox {

        width: parent.width * 0.49
        model: languages

        background: ESTextField{}
    }

    }

    Row {
        width:parent.width * 0.98
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: parent.width * 0.39
    Button {

        width: parent.width * 0.30
        background: ESTextField{}

        text:qsTr("Cancel")

        onClicked: {thisWindow.state = "inActive"}
    }

    Button {

        width: parent.width * 0.30
        background: ESTextField{}
        text:qsTr("Okay")

        onClicked: {thisWindow.state = "inActive"}
    }

    }


 }

}
