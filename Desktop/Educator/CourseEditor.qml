import QtQuick 2.11
import QtQuick.LocalStorage 2.0 as Sql

import "../theme"

ESborder {
    id: thisWindow

    property string unitTitle: "Title"
    property string unitAbout: "About"
    property string unitObjective: "Objective"

    Row {
        width: parent.width
        height: parent.height

        Flickable {
            width: parent.width * 0.50
            height: parent.height
            contentHeight: infoColumn.height

            Column {
                id: infoColumn
                width: parent.width
                spacing: parent.width * 0.01

                Text {
                    text: unitTitle
                    font.bold: true
                }

                Text {
                    text: unitObjective
                    width: parent.width
                    wrapMode: Text.WordWrap
                }

                Text {
                    text: unitAbout
                    width: parent.width
                    wrapMode: Text.WordWrap
                }
            }
        }

        Flickable {
            width: parent.width * 0.50
            height: parent.height
            contentHeight: lessonsColumn.height

            Column {
                id: lessonsColumn
                width: parent.width
                spacing: parent.width * 0.01
            }
        }
    }
}
