import QtQuick 2.11
import QtGraphicalEffects 1.0

Item {
   // clip: true
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
                properties: "opacity,anchors.verticalCenterOffset"
                duration: 300
                easing.type: Easing.InOutQuad
            }
        }
    ]

    state:"Active"



Rectangle {
    id:bg
    radius: 10
    color:"white"
    visible: false
    anchors.centerIn: parent
    width:parent.width * 0.99
    height:parent.height * 0.99

    RadialGradient {

           anchors.centerIn: parent
           width:parent.width * 0.99
           height:parent.height * 0.99
           gradient: Gradient {
               GradientStop { position: 0.3; color: "#FFFFFFFF" }
               GradientStop { position: 0.98; color: "#11F7F7F7" }
           }
       }
}

DropShadow {
    anchors.fill: bg
    source:bg
    radius: 5.0
    samples:17
    horizontalOffset:0
    verticalOffset: 4
    color: "#80000000"
}

}
