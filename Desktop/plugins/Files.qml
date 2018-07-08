import QtQuick 2.11
import QtQuick.Dialogs 1.2

FileDialog {
    id: fileDialog
    title: "Please choose a file"
    folder: shortcuts.home
    onAccepted: {
        console.log("You chose: " + fileDialog.fileUrls)
        fileDialog.visible = false
    }
    onRejected: {
       // console.log("Canceled")
        fileDialog.visible = false
    }
    nameFilters: [ "Image files (*.jpg *.png)", "All files (*)" ]
}
