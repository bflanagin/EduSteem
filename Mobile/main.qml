import QtQuick 2.11
import QtQuick.Window 2.11
import QtQuick.Window 2.3
import QtQuick.Controls 2.2
import QtMultimedia 5.9
import QtQuick.Controls.Material 2.2

Window {
    visible: true
    title: qsTr("Hello World")

    Text {
        anchors.centerIn: parent
        text:"Welcome"
        font.pixelSize: parent.width * 0.2
    }


}
