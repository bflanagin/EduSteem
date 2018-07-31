import QtQuick 2.11
import QtGraphicalEffects 1.0

Item {
    // clip: true
    id: thisWindow
    property double bgOpacity: 1
    property string fillcolor: "white"
    property bool clickable: false
    states: [

        State {
            name: "Active"
            PropertyChanges {

                target: thisWindow
                // opacity:1
                anchors.verticalCenterOffset: 0
            }
        },

        State {
            name: "inActive"
            PropertyChanges {

                target: thisWindow
                // opacity:0
                anchors.verticalCenterOffset: parent.height + height * 1.1
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
                // properties: "opacity,anchors.verticalCenterOffset"
                properties: "anchors.verticalCenterOffset"
                duration: 300
                easing.type: Easing.InOutQuad
            }
        }
    ]

    state: "Active"

    Rectangle {
        id: bg
        radius: 3
        color: "white"
        visible: false
        anchors.centerIn: parent
        width: parent.width * 0.99
        height: parent.height * 0.99


       RadialGradient {

            anchors.centerIn: parent
            width: parent.width * 0.95
            height: parent.height * 0.95
            gradient: Gradient {
                GradientStop {
                    position: 0.3
                    color: "white"
                }
                GradientStop {
                    position: 0.98
                    color: "#00F7F7F7"
                }
            }
        }
    }

    DropShadow {
        id:shadow
        anchors.fill: bg
        source: bg
        radius: 10.0
        samples: 17
        horizontalOffset: 1
        verticalOffset: 4
        color: "#80000000"
        opacity: bgOpacity
    }

    MouseArea {
        anchors.fill: parent

        hoverEnabled: clickable

        onEntered: {shadow.horizontalOffset = 6
                    shadow.verticalOffset = 10
                    }
        onExited: {shadow.horizontalOffset = 1
                    shadow.verticalOffset = 4
                    }
    }
}
