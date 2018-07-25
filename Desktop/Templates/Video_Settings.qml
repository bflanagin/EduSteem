import QtQuick 2.11
import QtMultimedia 5.9
import "../theme"
import "../plugins"
import "../General"

import "../Educator/course.js" as Courses


Item {
    width:parent.width
    height:parent.height

    Text {
        anchors.centerIn:parent
        text:qsTr("No Settings")
    }

}
