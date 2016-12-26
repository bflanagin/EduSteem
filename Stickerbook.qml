import QtQuick 2.0
import QtQuick.LocalStorage 2.0 as Sql

Item {
     id:window_container

    states: [

        State {
            name: "Show"

            PropertyChanges {
                target:window_container
                y:parent.height * 0.15

            }

        },

        State {
            name: "Hide"

            PropertyChanges {
                target:window_container
                y:parent.height


            }
        }

    ]

    transitions: [
        Transition {
            from: "Hide"
            to: "Show"
            reversible: true


            NumberAnimation {
                target: window_container
                property: "y"
                duration: 200
                easing.type: Easing.InOutQuad
            }
        }
    ]

    state:"Hide"

    Image {
        source:"graphics/settingsbg.png"
        anchors.horizontalCenter: parent.horizontalCenter
        width:parent.width
        height:parent.height
    }

    Text {
        id:title
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top:parent.top
        anchors.topMargin: parent.height * 0.02
        text:"Stickers"
        font.pixelSize: parent.height * 0.07
    }
    Rectangle {
        anchors.top:title.bottom
        anchors.topMargin: parent.height * 0.02
        anchors.horizontalCenter: parent.horizontalCenter
        width:parent.width * 0.85
        height:parent.height * 0.005
        color:"gray"
    }

    GridView {
        id:stickergrid
        anchors.left: parent.left
        anchors.top:title.bottom
        anchors.margins:parent.height * 0.05
        width:parent.width * 0.90
        height:parent.height * 0.73
        cellHeight: parent.height * 0.15
        cellWidth: parent.height * 0.15
        clip:true

        model: 6

        delegate:
                Rectangle {
                     width:stickergrid.cellWidth * 0.8
                        height:stickergrid.cellHeight * 0.8
                        border.color:"lightgray"
                        border.width:2
                        radius:4

             Image {
                source:"graphics/"+stickerbook+"/"+(modelData +1 )+".png"
                width:stickergrid.cellWidth * 0.6
                height:stickergrid.cellHeight * 0.6
                anchors.centerIn: parent
                }

             MouseArea {
                 anchors.fill:parent
                 onClicked:currentsticker = (modelData +1 ),window_container.state = "Hide"
             }

            }


    }


}
