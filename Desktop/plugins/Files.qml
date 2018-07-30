import QtQuick 2.11
import QtQuick.Dialogs 1.2

FileDialog {
    id: fileDialog

    property string type: "none"
    property string markdown:""

    //onTypeChanged: console.log(type)

    title: "Please choose a file"
    folder: shortcuts.home
    onAccepted: {
        fileDialog.fileUrls


        var thefile = fileDialog.fileUrl.toString().split("file://")[1]

        if(type === "profile") {
        tempImg = fileDialog.fileUrl
        }
        ipfs.start("ipfs",["add",thefile])
        ipfs.type = type
        ipfs.onReadChannelFinished(fileDialog.visible = false )

    }
    onRejected: {
        fileDialog.visible = false
        fileDialog.clearSelection()
        console.log("canceled")
    }
    nameFilters: [ "Image files (*.jpg *.png)", "All files (*)" ]
}
