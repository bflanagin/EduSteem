import QtQuick 2.11
import QtQuick.Controls 2.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0
import QtQuick.Dialogs 1.0

import "../theme"
import "../plugins"
import "../Educator/course.js" as Courses
import "../General/network.js" as Network
import "../plugins/text.js" as Scrubber
import "../General/general.js" as Scripts
import "../General/ipfs.js" as IPFS
Item {
    id: thisWindow

    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter

    states: [

        State {
            name: "Active"
            PropertyChanges {

                target: thisWindow
                opacity: 1
                anchors.verticalCenterOffset: 0
            }
        },

        State {
            name: "inActive"
            PropertyChanges {

                target: thisWindow
                opacity: 0
                anchors.verticalCenterOffset: parent.height + 500
            }
        }
    ]

    transitions: [
        Transition {
            from: "inActive"
            to: "Active"
            reversible: true

            NumberAnimation {
                target: thisWindow
                properties: "opacity,anchors.verticalCenterOffset"
                duration: 40
                easing.type: Easing.InOutQuad
            }
        }
    ]

    state: "inActive"

    onStateChanged: if(state === "Active") {
                        Scripts.load_Subjects()
                        Scripts.load_Educators()
                    }

    Rectangle {
        anchors.fill: parent
    }

    Text {
        id: title
        text: qsTr("Settings")
        anchors.top: parent.top
        anchors.left: backbutton.right
        anchors.margins: 20
        font.bold: true
        font.pointSize: 15
    }

    CircleButton {
        id: backbutton
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 20
        height: title.height
        width: title.height

        MouseArea {
            anchors.fill: parent
            onClicked: {
                thisWindow.state = "inActive"
                general.state = "Active"
            }
        }
    }

    Rectangle {
        anchors.top: title.bottom
        anchors.topMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width * 0.95
        height: 3
        color: seperatorColor
    }

    Flickable {
        anchors.top: title.bottom
        anchors.topMargin: 24
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width * 0.98
        contentHeight: cColumn.height

        clip: true

        Column {
            id: cColumn
            width: parent.width
            spacing: 10

            ESborder {
                anchors.horizontalCenter: parent.horizontalCenter
                width: thisWindow.width * 0.98
                height: aboutColumn.height + 23

                Column {
                    id: aboutColumn
                    anchors.top: parent.top
                    anchors.topMargin: 10
                    width: parent.width * 0.98
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 3

                    Text {
                        anchors.left: parent.left
                        font.bold: true
                        text: qsTr("About")
                        font.pointSize: 12
                    }

                    Rectangle {
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: parent.width * 0.99
                        height: 2
                        color: seperatorColor
                    }

                    Text {
                        id: about
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                        text: schoolAbout
                        wrapMode: Text.WordWrap
                        width: parent.width * 0.85
                    }

                    Image {
                        anchors.right: parent.right
                        anchors.rightMargin: 10
                        source: "/icons/edit-text.svg"
                        width: 24
                        height: 24
                        fillMode: Image.PreserveAspectFit

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                editthis.field = "About"
                                editthis.where = "school"
                                editthis.state = "Active"
                            }
                        }
                    }
                }
            }

            Row {
                width: parent.width * 0.98

                ESborder {

                    width: thisWindow.width * 0.49
                    height: startColumn.height + 23

                    Column {
                        id: startColumn
                        anchors.top: parent.top
                        anchors.topMargin: 10
                        width: parent.width * 0.98
                        anchors.horizontalCenter: parent.horizontalCenter
                        spacing: thisWindow.height * 0.01

                        Text {
                            anchors.left: parent.left
                            font.bold: true
                            text: qsTr("School Times:")
                            font.pointSize: 12
                        }

                        Rectangle {
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: parent.width * 0.99
                            height: 2
                            color: seperatorColor
                        }

                        Text {
                            anchors.left: parent.left
                            font.bold: true
                            text: qsTr("School Hours:")
                        }

                        Row {
                            width: parent.width
                            height: starttime.height
                            spacing: height * 0.2

                            ComboBox {
                                id: starttime
                                width: parent.width * 0.20
                                model: [5, 6, 7, 8, 9, 10, 11, 12]
                                displayText: currentText+ ":00 AM"
                                delegate: ItemDelegate {
                                    width:parent.width
                                    text:modelData+ ":00 AM"
                                }
                                background: ESTextField {
                                }
                            }
                            Text {
                                text: qsTr("to")
                                height: parent.height
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }

                            ComboBox {
                                id: endtime
                                width: parent.width * 0.20
                                model: [13, 14, 15, 16, 17, 18, 19, 20]
                                displayText: (currentText - 12)+ ":00 PM"
                                delegate: ItemDelegate {
                                    width:parent.width
                                    text:modelData - 12 + ":00 PM"
                                }

                                background: ESTextField {
                                }
                            }
                        }
                        Rectangle {
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: parent.width * 0.99
                            height: 5
                            color: "transparent"
                        }

                        Text {
                            anchors.left: parent.left
                            font.bold: true
                            text: qsTr("School Year:")
                        }
                        Item {
                            width: parent.width * 0.65
                            //anchors.horizontalCenter: parent.horizontalCenter
                            height: startMonth.height

                            ComboBox {
                                id: startMonth
                                anchors.left:parent.left
                                width: parent.width * 0.4
                                background: ESTextField {
                                }
                                model: monthList
                                textRole: "key"
                            }
                            Text {
                                anchors.right:schoolYear.left
                                text: qsTr("Year Length: ")
                                height: parent.height
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                            TextField {
                                anchors.right:parent.right
                                id:schoolYear
                                width: parent.width * 0.15
                                background: ESTextField {
                                }
                                placeholderText: "180"
                                text: schoolYearLength
                            }
                        }
                        Item {
                            width: parent.width * 0.65
                           // anchors.horizontalCenter: parent.horizontalCenter
                            height: startMonth.height

                            Text {
                                id:firstSemesterLabel
                                anchors.left:parent.left
                                text: qsTr("First Semester: ")
                                height: parent.height
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                            TextField {
                                anchors.left:firstSemesterLabel.right
                                width: parent.width * 0.1
                                background: ESTextField {
                                }
                                placeholderText: "90"
                                text: semester1Length
                            }
                            Text {
                                id:secondSemesterLabel
                                anchors.right:secondSemester.left
                                text: qsTr("Second Semester: ")
                                height: parent.height
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                            TextField {
                                id:secondSemester
                                anchors.right:parent.right
                                width: parent.width * 0.1
                                background: ESTextField {
                                }
                                placeholderText: "90"
                                text: semester2Length
                            }
                        }
                        Rectangle {
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: parent.width * 0.99
                            height: 5
                            color: "transparent"
                        }
                    }
                }

                ESborder {

                    width: thisWindow.width * 0.49
                    height: dowColumn.height + 23

                    Column {
                        id: dowColumn
                        anchors.top: parent.top
                        anchors.topMargin: 10
                        width: parent.width * 0.98
                        anchors.horizontalCenter: parent.horizontalCenter
                        spacing: 3

                        Text {
                            anchors.left: parent.left
                            font.bold: true
                            text: qsTr("Weekly Schedule")
                            font.pointSize: 12
                        }

                        Rectangle {
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: parent.width * 0.99
                            height: 2
                            color: seperatorColor
                        }
                        CheckBox {
                            id: sunday
                            text: qsTr("Sunday")
                        }

                        CheckBox {
                            id: monday
                            text: qsTr("Monday")
                        }
                        CheckBox {
                            id: tuesday
                            text: qsTr("Tuesday")
                        }
                        CheckBox {
                            id: wednesday
                            text: qsTr("Wednesday")
                        }
                        CheckBox {
                            id: thursday
                            text: qsTr("Thursday")
                        }
                        CheckBox {
                            id: friday
                            text: qsTr("Friday")
                        }
                        CheckBox {
                            id: staturday
                            text: qsTr("Saturday")
                        }
                    }
                }
            }

            ESborder {
                anchors.horizontalCenter: parent.horizontalCenter
                width: thisWindow.width * 0.98
                height: teacherColumn.height + 23

                Column {
                    id: teacherColumn
                    anchors.top: parent.top
                    anchors.topMargin: 10
                    width: parent.width * 0.98
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 3

                    Item {
                        width: parent.width
                        height: regtitle.height + 5

                        Text {
                            id: regtitle
                            anchors.left: parent.left
                            font.bold: true
                            text: qsTr("Registered Instructors")
                            font.pointSize: 12
                        }

                        CircleButton {
                            anchors.right: parent.right
                            icon: "/icons/add.svg"
                            fillcolor: "white"
                            width: regtitle.height
                            height: width
                        }
                    }

                    Rectangle {
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: parent.width * 0.99
                        height: 2
                        color: seperatorColor
                    }

                    Repeater {
                        width:parent.width
                        model:educators
                        clip:true

                        delegate: Rectangle {
                                    width:parent.width * 0.98
                                    height:80
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    color:if(index % 2) {"#FFFFFF"} else {"#F9F9F9"}
                                    Row {
                                        width:parent.width * 0.98
                                        height:parent.height * 0.8
                                        anchors.centerIn: parent
                                        spacing: height * 0.2
                                        Item {
                                            height:parent.height
                                            width:parent.height
                                        Image {
                                            id: profileImage
                                            anchors.centerIn: parent
                                            width: parent.height
                                            height: width
                                            fillMode: Image.PreserveAspectCrop
                                            visible: false
                                            source: IPFS.grabImage(code,"profile")
                                            antialiasing: true

                                            Image {
                                                anchors.fill: parent
                                                fillMode: Image.PreserveAspectCrop
                                                source:"/icons/frontC.png"
                                                z:-1
                                                antialiasing: true
                                            }
                                        }
                                        OpacityMask {
                                            source: profileImage
                                            anchors.fill: profileImage
                                            maskSource: mask
                                            antialiasing: true
                                        }

                                        }

                                        Text {
                                            anchors.verticalCenter: parent.verticalCenter
                                            text:firstname+" "+lastname
                                        }

                                    }
                                 }

                    }

                    Image {
                        anchors.right: parent.right
                        anchors.rightMargin: 10
                        source: "/icons/edit-text.svg"
                        width: 24
                        height: 24
                        fillMode: Image.PreserveAspectFit

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                editthis.field = "About"
                                editthis.where = "school"
                                editthis.state = "Active"
                            }
                        }
                    }
                }
            }

            ESborder {
                anchors.horizontalCenter: parent.horizontalCenter
                width: thisWindow.width * 0.98
                height: subjectsColumn.height + 23

                Column {
                    id: subjectsColumn
                    anchors.top: parent.top
                    anchors.topMargin: 10
                    width: parent.width * 0.98
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 3

                    Item {
                        width: parent.width
                        height: subjectstitle.height + 5

                        Text {
                            id: subjectstitle
                            anchors.left: parent.left
                            font.bold: true
                            text: qsTr("Subjects")
                            font.pointSize: 12
                        }

                        CircleButton {
                            anchors.right: parent.right
                            icon: "/icons/add.svg"
                            fillcolor: "white"
                            width: regtitle.height
                            height: width

                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                            subjectEdit.state = "Active"
                                            subjectEdit.edit = false
                                            subjectName.text = ""
                                            subjectNumber.text = ""
                                            }
                            }
                        }
                    }

                    Rectangle {
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: parent.width * 0.99
                        height: 2
                        color: seperatorColor
                    }

                    Repeater {
                        width:parent.width
                        model:subjects
                        clip:true


                        delegate: Rectangle {
                                    width:parent.width * 0.98
                                    height:60
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    color:if(index % 2) {"#FFFFFF"} else {"#F9F9F9"}
                                    Row {
                                        width:parent.width * 0.98
                                        height:parent.height * 0.8
                                        anchors.centerIn: parent
                                        spacing: height * 0.8

                                        Rectangle {
                                            color:classColor
                                            radius: width / 2
                                            height:parent.height
                                            width:parent.height
                                        }

                                        Text {
                                            text:name
                                            anchors.verticalCenter: parent.verticalCenter
                                            font.pixelSize: parent.height * 0.25
                                        }
                                    }

                                    Image {
                                        id:editIcon
                                        visible: false
                                        anchors.right: parent.right
                                        anchors.rightMargin: 10
                                        anchors.bottom:parent.bottom
                                        source: "/icons/edit-text.svg"
                                        width: 24
                                        height: 24
                                        fillMode: Image.PreserveAspectFit
                                    }

                                    MouseArea {
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        onEntered: {
                                           editIcon.visible = true
                                        }

                                        onExited: {
                                            editIcon.visible = false
                                        }

                                        onClicked: {
                                            subjectEdit.state = "Active"
                                            subjectEdit.edit = true
                                            colorDialog.color = classColor
                                            subjectName.text = name
                                            subjectNumber.text = classNum
                                        }
                                    }

                        }
                    }
                }
            }
        }
    }

    ESborder {
        id:subjectEdit
        width:parent.width * 0.50
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        height:seColumn.height + 20
        property bool edit: false

        state:"inActive"

        MouseArea {
            anchors.fill: parent
            onClicked: {}
        }

        Column {
            id:seColumn
            width:parent.width * 0.98
            anchors.centerIn: parent
            spacing: parent.width * 0.01

            Text {

                anchors.horizontalCenter: parent.horizontalCenter
                font.bold: true
                text: if(subjectEdit.edit == false) {qsTr("Add Subject")} else {qsTr("Edit Subject")}
                font.pointSize: 12
            }

            Rectangle {
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width * 0.99
                height: 2
                color: seperatorColor
            }

            Row {
                width:parent.width * 0.98
                anchors.horizontalCenter: parent.horizontalCenter
                height:100
                spacing: 10

                Rectangle {
                    width:parent.height
                    height:parent.height
                    radius: width /2
                    color:colorDialog.color

                    MouseArea {
                        anchors.fill: parent
                        onClicked: colorDialog.visible = true
                    }

                    Text {
                        anchors.top:parent.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                        text:qsTr("Color Select")
                    }
                }

                Rectangle {
                    anchors.verticalCenter: parent.verticalCenter
                    width: 2
                    height: parent.height
                    color: seperatorColor
                }

                Column {
                    width:parent.width * 0.7
                    height:parent.height * 0.98
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: subjectEdit.height * 0.15
                    padding: subjectEdit.height * 0.08
                    Text {
                        text:qsTr("Subject: ")

                    TextField {
                        id:subjectName
                        anchors.left: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        width:subjectEdit.width * 0.65
                        placeholderText: qsTr("Subject Name")
                        background: ESTextField {}
                    }
                }
                    Text {
                        text:qsTr("Subject Number: ")

                    TextField {
                        id:subjectNumber
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left:parent.right
                        placeholderText: qsTr("401")
                        background: ESTextField {}
                    }
                    }

                }

            }
            Rectangle {
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width * 0.99
                height: subjectEdit.height * 0.04
                color: "transparent"
            }

            Item {
                width:parent.width * 0.98
                height:cancelButton.height
                anchors.horizontalCenter: parent.horizontalCenter
                Button {
                    id:cancelButton
                    anchors.left:parent.left
                    width: parent.width * 0.30
                    background: ESTextField {
                    }

                    text: qsTr("Cancel")

                    onClicked: {

                        subjectEdit.state = "inActive"
                        subjectEdit.edit = false
                    }
                }

                Button {
                    anchors.right:parent.right
                    width: parent.width * 0.30
                    background: ESTextField {
                    }


                    text: if(subjectEdit.edit == false) {qsTr("Add")} else {qsTr("Update")}

                    onClicked: {
                        if(subjectEdit.edit == false) {
                            Scripts.add_Subject(subjectName.text,subjectNumber.text,colorDialog.color)
                        }

                       subjectEdit.state = "inActive"
                        subjectEdit.edit = false
                    }
                }
            }
        }
    }

    ColorDialog {
        id: colorDialog
        visible:false
        title: "Please choose a color"
    }


    ListModel {
        id: monthList

        ListElement {
            key: "January"
            value: 0
        }
        ListElement {
            key: "Febuary"
            value: 1
        }
        ListElement {
            key: "March"
            value: 2
        }
        ListElement {
            key: "April"
            value: 3
        }
        ListElement {
            key: "May"
            value: 4
        }
        ListElement {
            key: "June"
            value: 5
        }
        ListElement {
            key: "July"
            value: 6
        }
        ListElement {
            key: "August"
            value: 7
        }
        ListElement {
            key: "September"
            value: 8
        }
        ListElement {
            key: "October"
            value: 9
        }
        ListElement {
            key: "November"
            value: 10
        }
        ListElement {
            key: "December"
            value: 11
        }
    }

    ListModel {
        id:subjects
    }

    ListModel {
        id:educators
    }
}
