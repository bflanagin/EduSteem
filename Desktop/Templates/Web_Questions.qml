import QtQuick 2.11
import QtWebEngine 1.7
import "../theme"
import "../plugins"
import "../General"

import "../Educator/course.js" as Courses
import "../General/network.js" as Network
import "../Student/student.js" as Students

Item {
    id:thisWindow
    width: parent.width * 0.98
    height:parent.height * 0.98
    property string url: "none"

    ESborder {
        anchors.horizontalCenter: parent.horizontalCenter
        width:parent.width * 0.90
        anchors.top:parent.top
        anchors.bottom:parent.bottom
        anchors.bottomMargin: parent.height * 0.1
    WebEngineView {
        anchors.fill: parent
        anchors.margins: 20
        url:thisWindow.url
        enabled:thisWindow.visible
        settings.webGLEnabled: true
        settings.pluginsEnabled: true
    }

    }

}
