import QtQuick 2.11
import QtQuick.Controls 2.4


Switch {
    id:finishedWork
    width:parent.width
    text: "Finished:"

    indicator: Rectangle {
            implicitWidth: 50
            implicitHeight: 26
            anchors.right:parent.right
            anchors.rightMargin: 10
            //x: finishedWork.leftPadding
            y: finishedWork.height / 2 - height / 2
            radius: 13
            color: finishedWork.checked ? seperatorColor : "#ffffff"
            border.color: finishedWork.checked ? seperatorColor : "#cccccc"

            Rectangle {
                x: finishedWork.checked ? parent.width - width : 0
                width: 26
                height: 26
                radius: 13
                color: finishedWork.down ? "#cccccc" : "#ffffff"
                border.color: finishedWork.checked ? (finishedWork.down ? seperatorColor : seperatorColor) : "#999999"
            }
        }

    contentItem: Text {
           text: finishedWork.text
           font: finishedWork.font
           opacity: enabled ? 1.0 : 0.3
           //color: finishedWork.down ? seperatorColor : seperatorColor
           color:"black"
           verticalAlignment: Text.AlignVCenter
           //leftPadding: -parent.indicator.width -parent.spacing
    }

}
