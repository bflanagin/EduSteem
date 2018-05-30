import QtQuick 2.11
import QtGraphicalEffects 1.0

Item {
    clip: true

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
               GradientStop { position: 0.3; color: "#FFFFFF" }
               GradientStop { position: 0.98; color: "#F7F7F7" }
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
