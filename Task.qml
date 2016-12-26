import QtQuick 2.0

import QtQuick.LocalStorage 2.0 as Sql
import "main.js" as Scripts
import "openseed.js" as OpenSeed

Item {

    property string taskname: ""
    property string monStick: ""
    property string tueStick: ""
    property string wedStick: ""
    property string thuStick: ""
    property string friStick: ""
    property string satStick: ""
    property string sunStick: ""

     Row {
        id:task
        height:parent.height
        width:parent.width

        Rectangle {
            width:parent.width / 6
            height:parent.height
            color:Qt.rgba(0.9,0.9,0.9,0.5)
            border.color:"gray"
        Text {
            text:taskname
            anchors.centerIn: parent
           font.pixelSize: parent.height * 0.4
        }
    }
        Rectangle {
            width:parent.width / 8.4
            height:parent.height
            color:Qt.rgba(0.9,0.9,0.9,0.5)
            border.color:"gray"

            Image {
                anchors.centerIn: parent
                source:monStick
                fillMode:Image.PreserveAspectFit
                width:parent.width * 0.7
                height:parent.height * 0.7

            }

            MouseArea {
                anchors.fill:parent
                onClicked: monStick = "graphics/"+stickerbook+"/"+currentsticker+".png",Scripts.stickerChange(childname,taskname),OpenSeed.stickerupdate(childname,taskname)
                onPressAndHold: monStick = "graphics/blank.png",Scripts.stickerChange(childname,taskname),OpenSeed.stickerupdate(childname,taskname)
            }



    }
        Rectangle {
            width:parent.width / 8.4
            height:parent.height
            color:Qt.rgba(0.9,0.9,0.9,0.5)
            border.color:"gray"
            Image {
                anchors.centerIn: parent
                source:tueStick
                fillMode:Image.PreserveAspectFit
                width:parent.width * 0.7
                height:parent.height * 0.7
            }

            MouseArea {
                anchors.fill:parent
                onClicked: tueStick = "graphics/"+stickerbook+"/"+currentsticker+".png",Scripts.stickerChange(childname,taskname),OpenSeed.stickerupdate(childname,taskname)
                onPressAndHold: tueStick = "graphics/blank.png",Scripts.stickerChange(childname,taskname),OpenSeed.stickerupdate(childname,taskname)
            }



    }
        Rectangle {
            width:parent.width / 8.4
            height:parent.height
            color:Qt.rgba(0.9,0.9,0.9,0.5)
            border.color:"gray"
            Image {
                anchors.centerIn: parent
                source:wedStick
                fillMode:Image.PreserveAspectFit
                width:parent.width * 0.7
                height:parent.height * 0.7
            }

            MouseArea {
                anchors.fill:parent
                onClicked: wedStick = "graphics/"+stickerbook+"/"+currentsticker+".png",Scripts.stickerChange(childname,taskname),OpenSeed.stickerupdate(childname,taskname)
                onPressAndHold: wedStick = "graphics/blank.png",Scripts.stickerChange(childname,taskname),OpenSeed.stickerupdate(childname,taskname)
            }


    }
        Rectangle {
            width:parent.width / 8.4
            height:parent.height
            color:Qt.rgba(0.9,0.9,0.9,0.5)
            border.color:"gray"
            Image {
                anchors.centerIn: parent
                source:thuStick
                fillMode:Image.PreserveAspectFit
                width:parent.width * 0.7
                height:parent.height * 0.7
            }

            MouseArea {
                anchors.fill:parent
                onClicked: thuStick = "graphics/"+stickerbook+"/"+currentsticker+".png",Scripts.stickerChange(childname,taskname),OpenSeed.stickerupdate(childname,taskname)
                onPressAndHold: thuStick = "graphics/blank.png",Scripts.stickerChange(childname,taskname),OpenSeed.stickerupdate(childname,taskname)
            }

    }
        Rectangle {
            width:parent.width / 8.4
            height:parent.height
            color:Qt.rgba(0.9,0.9,0.9,0.5)
            border.color:"gray"
            Image {
                anchors.centerIn: parent
                source:friStick
                fillMode:Image.PreserveAspectFit
                width:parent.width * 0.7
                height:parent.height * 0.7
            }

            MouseArea {
                anchors.fill:parent
                onClicked: friStick = "graphics/"+stickerbook+"/"+currentsticker+".png",Scripts.stickerChange(childname,taskname),OpenSeed.stickerupdate(childname,taskname)
                onPressAndHold: friStick = "graphics/blank.png",Scripts.stickerChange(childname,taskname),OpenSeed.stickerupdate(childname,taskname)
            }


    }
        Rectangle {
            width:parent.width / 8.4
            height:parent.height
            color:Qt.rgba(0.9,0.9,0.9,0.5)
            border.color:"gray"
            Image {
                anchors.centerIn: parent
                source:satStick
                fillMode:Image.PreserveAspectFit
                width:parent.width * 0.7
                height:parent.height * 0.7
            }
            MouseArea {
                anchors.fill:parent
                onClicked: satStick = "graphics/"+stickerbook+"/"+currentsticker+".png",Scripts.stickerChange(childname,taskname),OpenSeed.stickerupdate(childname,taskname)
                onPressAndHold: satStick = "graphics/blank.png",Scripts.stickerChange(childname,taskname),OpenSeed.stickerupdate(childname,taskname)
            }

    }
        Rectangle {
            width:parent.width / 8.4
            height:parent.height
            color:Qt.rgba(0.9,0.9,0.9,0.5)
            border.color:"gray"
            Image {
                anchors.centerIn: parent
                source:sunStick
                fillMode:Image.PreserveAspectFit
                width:parent.width * 0.7
                height:parent.height * 0.7
            }

            MouseArea {
                anchors.fill:parent
                onClicked: sunStick = "graphics/"+stickerbook+"/"+currentsticker+".png",Scripts.stickerChange(childname,taskname),OpenSeed.stickerupdate(childname,taskname)
                onPressAndHold: sunStick = "graphics/blank.png",Scripts.stickerChange(childname,taskname),OpenSeed.stickerupdate(childname,taskname)
            }

    }


    }


}

