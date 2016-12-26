import QtQuick 2.0
import QtQuick.Controls 1.4
import 'main.js' as Scripts
import 'openseed.js' as OpenSeed

import QtQuick.LocalStorage 2.0 as Sql

Item {
    id:window_container

    property int type: 0


   states: [

       State {
           name: "Show"

           PropertyChanges {
               target:window_container
               y:parent.height * 0.30

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
        anchors.top:parent.top
        anchors.topMargin: parent.height * 0.02
        anchors.horizontalCenter: parent.horizontalCenter
        text:if(type == 0) {"Add Child"} else {"Add Task"}
        font.pixelSize: parent.height * 0.1
    }
    Rectangle {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top:title.bottom
        width:parent.width * 0.90
        height:parent.height * 0.01
        color:"gray"

    }

    Column {
        anchors.centerIn: parent
        visible:if(type == 0) {true} else {false}

        width:parent.width * 0.90
        height:parent.height * 0.70
        spacing:parent.height * 0.05
        clip:true

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text:"Name"
            font.pixelSize: parent.height * 0.1

        }

        TextField {
            id:childname
            anchors.horizontalCenter: parent.horizontalCenter
            width:parent.width
            placeholderText: "Name"
            font.pixelSize: parent.height * 0.1
        }

        Text {
            text:"Birthday:"
            font.pixelSize: parent.height * 0.1

            TextField {
                id:childbday
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.right
                width:parent.width
                placeholderText: "dd/mm/yy"
                font.pixelSize: parent.height
            }

        }

    }


    Column {
        anchors.centerIn: parent
        visible:if(type == 1) {true} else {false}

        width:parent.width * 0.90
        height:parent.height * 0.65
        spacing:parent.height * 0.05
       // clip:true

        Text {
            //anchors.horizontalCenter: parent.horizontalCenter
            text:"Name:"
            font.pixelSize: parent.height * 0.1

            TextField {
                id:taskname
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.right
                width:parent.width * 1.6
                placeholderText: "Name"
                font.pixelSize: parent.height
                maximumLength: 12
            }

        }

        Text {
            text:"Discription:"
            font.pixelSize: parent.height * 0.1


        }
        TextField {
            id:taskdiscript
            width:parent.width
            height:parent.height * 0.4
            placeholderText: "Do this and that"
            font.pixelSize: parent.height * 0.1
            maximumLength: 144
        }

    }






    Rectangle {
        id:addbutton
        anchors.bottom:parent.bottom
        anchors.left:parent.left
        anchors.margins:parent.height * 0.06
        width:parent.height * 0.3
        height:parent.height * 0.1
        color:"white"
        border.color: "red"
        radius:8

        Text {
            anchors.centerIn: parent
            font.pixelSize: parent.height * 0.4
            text:"Add"
        }

        MouseArea {
            anchors.fill:parent
            onClicked:{ if(type == 1) {currenttask = taskname.text,
                                       Scripts.addtask(taskname.text,taskdiscript.text),
                                       OpenSeed.sendtask(taskname.text,taskdiscript.text,id)
                                       window_container.state = "Hide",scheduleit.state = "Show"}
                                        else {window_container.state = "Hide",
                                              Scripts.addchild(childname.text,childbday.text)
                                                OpenSeed.sendchild(childname.text,childbday.text,id)
                                        }
                            thesettings.state = "Show"
            }
        }
    }

    Rectangle {
        id:cancelbutton
        anchors.bottom:parent.bottom
        anchors.left:addbutton.right
        anchors.margins:parent.height * 0.06
        radius:8


        width:parent.height * 0.3
        height:parent.height * 0.1
        color:"white"
        border.color: "red"

        Text {
            anchors.centerIn: parent
            font.pixelSize: parent.height * 0.4
            text:"Cancel"
        }

        MouseArea {
            anchors.fill:parent
            onClicked:window_container.state = "Hide",thesettings.state = "Show"
        }
    }




}

