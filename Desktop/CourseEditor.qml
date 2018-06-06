import QtQuick 2.11
import QtQuick.LocalStorage 2.0 as Sql

ESborder {
    id:thisWindow

    property string UnitTitle:"Title"
    property string UnitAbout:"About"
    property string UnitObjective:"Objective"


    Row {
        width:parent.width
        height:parent.height

        Flickable {
            width:parent.width * 0.50
            height:parent.height
            contentHeight: infoColumn.height

            Column {
                id:infoColumn
                width:parent.width
                spacing: parent.width * 0.01

                Text {
                    text:UnitTitle
                    font.bold: true
                }

                Text {
                    text:UnitObjective
                    width:parent.width
                    wrapMode: Text.WordWrap
                }

                Text {
                    text:UnitAbout
                    width:parent.width
                    wrapMode: Text.WordWrap
                }

            }
        }

        Flickable {
            width:parent.width * 0.50
            height:parent.height
            contentHeight: lessonsColumn.height

            Column {
                id:lessonsColumn
                width:parent.width
                spacing: parent.width * 0.01
            }
        }

    }

}
