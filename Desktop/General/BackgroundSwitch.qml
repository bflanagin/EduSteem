import QtQuick 2.11
import QtGraphicalEffects 1.0

Item {

    id: thisWindow
    anchors.fill: parent

    property double op: 0.2

    states: [

        State {
            name: "Active"
            PropertyChanges {
                target: thisWindow
                opacity: 1
            }
        },

        State {
            name: "inActive"

            PropertyChanges {
                target: thisWindow
                opacity: 0
            }
        }


    ]

    state: "inActive"

    transitions: [

        Transition {
            from: "inActive"
            to: "Active"
            reversible: true

            NumberAnimation {
                target: thisWindow
                property: "opacity"
                duration: 400
                easing.type: Easing.InOutQuad
            }
        }
    ]

    Image {
        id: bg
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        source: "https://heliograph.vagueentertainment.com/web/img/HumbleBeaver_1110.jpg"
        visible: false
        onStatusChanged: thisWindow.state = "Active"
    }

    FastBlur {
        source: bg
        anchors.fill: bg
        radius: 64
    }

    Rectangle {
        id: overlay
        anchors.fill: parent
        color: "#FFFFFF"
        opacity: op

    }
}
