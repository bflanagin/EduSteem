import QtQuick 2.11

Item {
id:thisWindow
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

    Text {
        id:title
        text: "Course Name"
        anchors.top:parent.top
        anchors.left: parent.left
        anchors.margins: 20
        font.bold: true
        font.pointSize: 15
    }


    Rectangle {
        anchors.top:title.bottom
        anchors.topMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width * 0.95
        height: 3
        color: seperatorColor
    }

    Flickable {
        anchors.top:title.bottom
        anchors.topMargin: 20
        anchors.bottom:parent.bottom
        width:parent.width
        contentHeight: cColumn.height
        clip: true
        Column {
            anchors.top: parent.top
            anchors.topMargin: 10
            id: cColumn
            width: parent.width
            spacing: mainView.width * 0.01

        }

    }

}
