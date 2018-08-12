import QtQuick 2.11
import QtQuick.Window 2.11
import QtQuick.Window 2.3
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2

import "../Theme"
import "../Plugins"
import "../Logic/network.js" as Network
import "../Logic/supplies.js" as Supply
import "../Logic/general.js" as Scripts
import "../Plugins/text.js" as Scrubber

ESborder {

    property string supplies: "current"
    //property string thelist: ""

    onVisibleChanged: if (visible === true) {
                          Supply.load_supplies(schoolCode,supplies)
                          shadeTimer.start()
                      }
    onSuppliesChanged: {
                           Supply.load_supplies(schoolCode,supplies)
                            shadeTimer.start()
                       }


    anchors.horizontalCenter: parent.horizontalCenter
    width: parent.width * 0.94
    height: cColumn.height + 10

    Column {
       id:cColumn
        width:parent.width * 0.98
        spacing:parent.width * 0.1
        anchors.centerIn: parent
        Text {
            font.bold: true
            text: switch(supplies) {
                  case "current": qsTr("Current")
                      break
                  case "next": qsTr("Next Lessons")
                      break
                  case "nextWeek": qsTr("Comming Up")
                      break
                  }
        }

        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            width:parent.width * 0.95
            height:1
            color:seperatorColor
        }

        ListView {
            width:parent.width
            height:contentHeight
            enabled: false
            model:supList
            delegate: Column {
                        width: parent.width * 0.98
                        spacing: width * 0.01
                       MarkDown {
                            width: parent.width
                            editable: false
                            thedata: Scrubber.recoverSpecial(theLesson)
                        }

                    MarkDown {
                        width: parent.width
                        editable: false
                        thedata: Scrubber.recoverSpecial(thelist)

                    }

            }

        }

    }

    ListModel {
        id:supList
    }
}
