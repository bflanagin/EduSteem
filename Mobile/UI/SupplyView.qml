import QtQuick 2.11
import QtQuick.Window 2.11
import QtQuick.Window 2.3
import QtQuick.Controls 2.2
import QtMultimedia 5.9
import QtQuick.Controls.Material 2.2

import "../Plugins"
import "../Theme"

    Column {

        spacing: parent.width * 0.05
        property string thelist: "No Supplies Needed"

        Supplies {
            id: supplyViewCurrent
            supplies: "current"
            visible: supplyView.visible

        }

        Supplies {
            id: supplyViewNext
            supplies: "next"
            visible: supplyView.visible

        }

        Supplies {
            id: supplyViewNextWeek
            supplies: "nextWeek"
            visible: supplyView.visible

        }
    }

