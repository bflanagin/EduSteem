import QtQuick 2.9

import "./markdown.js" as MarkDown


/* For posts that use markdown we can not reformat the posts without sending it through some sort of filter, once done the data is sent to the Item below and added into a listView.
  The list has no spacing so each line of text looks like it belongs to the last giving a very unified look to the display */
Item {
    id: thisWindow
    property string thedata: ""
    height: markeddownList.height

    onThedataChanged: MarkDown.md2qml(thedata)

    ListView {
        id: markeddownList
        width: parent.width
        height: contentHeight + 20
        boundsBehavior: Flickable.StopAtBounds

        model: markdown

        delegate: Item {
            anchors.horizontalCenter: parent.horizontalCenter
            width: thisWindow.width * 0.98
            height: if (textItem.visible == true) {
                        textItem.height
                    } else if (imageItem.visible == true ) {
                        if( imageItem.status == Image.Ready) {
                                    imageItem.height
                        } else {
                            width
                        }
                    } else if (codeItem.visible == true) {
                        5
                    }

            /* If the data is Text the Text Item is displayed */
            Text {
                id: textItem
                anchors.centerIn: parent
                width: parent.width
                visible: if (type == "text") {
                             true
                         } else {
                             false
                         }
                wrapMode: Text.WordWrap
                clip: true
                horizontalAlignment: Text.AlignLeft
                //font.pixelSize: thisWindow.width * 0.04
                text: "<div>" + thepost + "</div>"
            }
            /* If the data is an Image the Image Item is displayed */
            Image {
                id: imageItem
                enabled: if (type == "image") {
                             true
                         } else {
                             false
                         }
                visible: if (type == "image") {
                             true
                         } else {
                             false
                         }
                source: img
                anchors.centerIn: parent
                fillMode: Image.PreserveAspectFit
                width: parent.width    
            }

            /* If the data is ``` the Code line Item is displayed */
            Rectangle {
                id: codeItem
                anchors.centerIn: parent
                width: parent.width
                height: 3
                color: highLightColor1
                visible: if (type == "code") {
                             true
                         } else {
                             false
                         }
            }

             /* If the data is --- the Code line Item is displayed */
            Rectangle {
                id: seperator
                anchors.centerIn: parent
                width: parent.width
                height: 2
                color: seperatorColor
                visible: if (type == "seperator") {
                             true
                         } else {
                             false
                         }
            }
        }
    }

    ListModel {
        id: markdown
    }
}
