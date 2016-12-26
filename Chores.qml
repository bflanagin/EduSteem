import QtQuick 2.0

import 'main.js' as Scripts
import 'openseed.js' as OpenSeed

import QtQuick.LocalStorage 2.0 as Sql

Item {


    Timer {
        id:updateassignment
        interval: 10
        repeat:false
        running:false
        onTriggered: Scripts.assignments(),stickersync.running = true
    }

    Timer {
        id:firstrun
        interval: 10
        repeat:false
        running:true
        onTriggered: Scripts.familylist(0)
    }

    Timer {
        id:stickersync
        interval: 20000
        repeat:true
        running:false
        onTriggered: if(id.length > 2) {
                         Scripts.updatedata();
                     }
    }




    Rectangle {
        anchors.fill: parent
        color:Qt.rgba(0.9,0.9,0.9,0.8)
    }




    Image {
        id:background
        source:"graphics/bg1.png"
        anchors.fill: parent
        fillMode:Image.PreserveAspectCrop
        anchors.top:parent.top
        opacity:0.5
    }

    Rectangle {
        anchors.centerIn: listtopper
        border.color:"black"
        width:listtopper.width * 1.01
        height:listtopper.height * 1.01
    }

    Row {
        id:listtopper
        y:nameback.height + nameback.y
        anchors.left:parent.left
        anchors.leftMargin:parent.height * 0.02
        height:parent.height * 0.06
        width:parent.width - parent.height * 0.04

        Rectangle {
            width:parent.width / 6
            height:parent.height
            color:Qt.rgba(0.9,0.9,0.0,0.5)


        Text {
            text:"Days:"
            anchors.centerIn: parent
           font.pixelSize: parent.height * 0.4
        }
    }
        Rectangle {
            width:parent.width / 8.4
            height:parent.height
            color:Qt.rgba(0.8,0.9,0.0,0.5)

        Text {
            text:"M"
            anchors.centerIn: parent
            font.pixelSize: parent.height * 0.5
        }
    }
        Rectangle {
            width:parent.width / 8.4
            height:parent.height
            color:Qt.rgba(0.7,0.9,0.0,0.5)

        Text {
            text:"T"
            anchors.centerIn: parent
            font.pixelSize: parent.height * 0.5
        }
    }
        Rectangle {
            width:parent.width / 8.4
            height:parent.height
            color:Qt.rgba(0.6,0.9,0.0,0.5)

        Text {
            text:"W"
            anchors.centerIn: parent
            font.pixelSize: parent.height * 0.5
        }
    }
        Rectangle {
            width:parent.width / 8.4
            height:parent.height
            color:Qt.rgba(0.5,0.9,0.0,0.5)

        Text {
            text:"Th"
            anchors.centerIn: parent
            font.pixelSize: parent.height * 0.5
        }
    }
        Rectangle {
            width:parent.width / 8.4
            height:parent.height
            color:Qt.rgba(0.4,0.9,0.0,0.5)
        Text {
            text:"F"
            anchors.centerIn: parent
            font.pixelSize: parent.height * 0.5
        }
    }
        Rectangle {
            width:parent.width / 8.4
            height:parent.height
            color:Qt.rgba(0.3,0.9,0.0,0.5)
        Text {
            text:"S"
            anchors.centerIn: parent
            font.pixelSize: parent.height * 0.5
        }
    }
        Rectangle {
            width:parent.width / 8.4
            height:parent.height
            color:Qt.rgba(0.9,0.9,0.2,0.5)
        Text {
            text:"Su"
            anchors.centerIn: parent
            font.pixelSize: parent.height * 0.5
        }
    }


    }


    ListView {
        id:listlist
        anchors.top:listtopper.bottom
        anchors.topMargin: parent.height * 0.002
        anchors.horizontalCenter: parent.horizontalCenter
        width:parent.width * 0.99
        height:parent.height - listtopper.height + listtopper.y
        spacing: parent.height * 0.005
        clip:true

        model: ListModel {
               id:assginedlist
        }

        delegate:
            Task {
                    anchors.horizontalCenter: parent.horizontalCenter
                    height: listlist.height * 0.06
                    width:listlist.width * 0.94
                    taskname: thetaskname
                    monStick: themonStick
                    tueStick: thetueStick
                    wedStick: thewedStick
                    thuStick: thethuStick
                    friStick: thefriStick
                    satStick: thesatStick
                    sunStick: thesunStick
                    }



    }

    Image {
        id:settingback

        states: [
            State {
                name:"Show"

                PropertyChanges {
                    target:settingback
                    x:(nameback.x+nameback.width) * 0.90
                }

                PropertyChanges {
                    target:nameback
                    x:-settingback.width * 0.98
                }
            },
            State {
                name:"Hide"
                when:thesettings.state == "Hide"

                PropertyChanges {
                    target:settingback
                    x:-settingback.width
                }
                PropertyChanges {
                    target:nameback
                    x:if(childname == "None") {-(name.width * 0.95)} else {0}
                }
            }




        ]
        state: "Hide"


        y:parent.height * 0.008
        height:parent.height * 0.06
        width:settings.width * 1.4
        source:"graphics/settings.png"

        Text {
            id:settings
            text:"Settings"
            font.pixelSize: parent.height * 0.5
            color:"white"
            anchors.centerIn: parent
        }

        MouseArea {
            anchors.fill:parent
            onClicked:thesettings.state = "Show"
        }

    }

    Image {
        id:nameback
       // x:if(childname == "None") {-(name.width * 0.95)} else {0}
        y:parent.height * 0.01
        height:parent.height * 0.07
        width:name.width * 1.4
        source:"graphics/name1.png"

        Text {
            id:name
            text:childname
            font.pixelSize: parent.height * 0.5
            color:"white"
            anchors.centerIn: parent
        }

        MouseArea {
            anchors.fill:parent
            onClicked:thechildren.state = "Show"
            onPressAndHold:settingback.state = "Show"
        }

    }



    Image {
        id:stick
        source:"graphics/"+stickerbook+"/"+currentsticker+".png"
        fillMode:Image.PreserveAspectFit
        anchors.bottom:parent.bottom
        //anchors.right:parent.right
        x:parent.width - parent.width * 0.36
        anchors.bottomMargin:parent.height * 0.045
        transformOrigin: Item.Center
        width:parent.height * 0.15
        height:parent.height * 0.15

        MouseArea {
            anchors.fill:parent

           /* onClicked:switch(currentsticker) {
                case 1:currentsticker = 2;break;
                    case 2:currentsticker = 3;break;
                        case 3:currentsticker = 1;break;
                            default:currentsticker = 1;break;
            } */

            onClicked: thestickerbook.state = "Show"
        }
    }


    Image {
        id:border
        source:"graphics/border1.png"
        anchors.fill:parent

    }

    Familyselect {
        id:thefamilies
        anchors.horizontalCenter:parent.horizontalCenter
        width: parent.width * 0.9
        height: parent.height * 0.7
        state:"Hide"

    }



    Childselect {
        id:thechildren
        anchors.horizontalCenter:parent.horizontalCenter
        width: parent.width * 0.9
        height: parent.height * 0.7
        state:"Hide"
    }


}

