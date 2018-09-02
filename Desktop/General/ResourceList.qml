import QtQuick 2.11
import QtQuick.Controls 2.2
import Process 1.0

import "../theme"
import "../plugins"
import "../Educator"

import "../Educator/course.js" as Courses
import "../plugins/text.js" as Scrubber
import "../plugins/markdown.js" as MD

ListView {
    id: thisView
    property string thedata: ""
    property double listItemHeight: 150
    property bool edit: false

    property string field: ""
    property string where: ""
    property real itemId: 0

    clip:true
    spacing:listItemHeight * 0.25
    model: thedata.split("\n")


    delegate: ESborder {
        clickable: true
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width * 0.98
        height: if(visible == false) {0} else {listItemHeight}
        visible: if(thisView.thedata.split("\n")[index].length > 4) {true} else {false}

        Item {
            id:imageContent
            anchors.centerIn: parent
            width:parent.width * 0.98
            height:parent.height * 0.98
            visible: if(thedata.split("\n")[index].split("[")[1].split("]")[0] === "IMG") {true} else {false}
            clip:true
        Image {
            anchors.centerIn: image
            width:image.width * 0.87
            source: "/icons/photo.svg"
            fillMode: Image.PreserveAspectFit
        }

        MarkDown {
            id:image
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 10
            anchors.left:parent.left
            anchors.leftMargin: parent.width * 0.01
            width:parent.height * 0.9
            thedata: thisView.thedata.split("\n")[index].split("*")[1]
        }

        Text {
            anchors.left:image.right
            anchors.verticalCenter: parent.verticalCenter
            text:thisView.thedata.split("\n")[index].split("*")[1].split("](")[1].split(")")[0]
            width:(parent.width - image.width) * 0.95
            wrapMode: Text.WordWrap
            clip:true
        }
      }

        Item {
            id:videoContent
            width:parent.width
            height:parent.height
            visible: if(thedata.split("\n")[index].split("[")[1].split("]")[0] === "VID") {true} else {false}

       Rectangle {
            id:vid
            anchors.verticalCenter: parent.verticalCenter
            anchors.left:parent.left
            anchors.leftMargin: parent.width * 0.01
            width:parent.height * 0.8
            height:parent.height * 0.8
            color:"black"

            Image {
                anchors.centerIn: parent
                width:parent.height * 0.9
                fillMode: Image.PreserveAspectFit
                source:"/icons/media-playback-start.svg"
            }
        }
        Text {
            anchors.left:vid.right
            anchors.verticalCenter: parent.verticalCenter
            text:thisView.thedata.split("\n")[index].split("*")[1]
            width:parent.width - image.width
            wrapMode: Text.WordWrap

        }
      }

        Item {
            id:webContent
            width:parent.width
            height:parent.height
            visible: if(thedata.split("\n")[index].split(" [")[1] !== undefined) {true} else {false}

            Image {
                id:web
                anchors.verticalCenter: parent.verticalCenter
                anchors.left:parent.left
                anchors.leftMargin: parent.width * 0.01
                width:parent.width * 0.3
                fillMode: Image.PreserveAspectFit
                source:"../icons/network.svg"
            }

        Text {
            anchors.left:web.right
            anchors.verticalCenter: parent.verticalCenter
            text:thisView.thedata.split("\n")[index].split("*")[1]
            width:parent.width - image.width
            wrapMode: Text.WordWrap

        }
      }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                resourceView.media = thisView.thedata.split("\n")[index]
                resourceView.state = "Active"
                resourceView.edit = edit
                resourceView.fulldata = thedata
                resourceView.where = thisView.where
                resourceView.itemId = thisView.itemId
                resourceView.field = thisView.field
            }

        }

    }
}
