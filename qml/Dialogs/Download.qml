import QtQuick 2.12
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3
import Ubuntu.DownloadManager 1.2
import Ubuntu.Content 1.3

import "../Content/MimeTypeMapper.js" as MimeTypeMapper
import "/qml/Utils.js" as JS

Dialog {
    id: downloadDialog

    // workaround to inherit webengine download item
    property var downloadItem
    property var hrttl
    property var hrrc: JS.humanFileSize(downloadItem.receivedBytes)

    property real progress: (downloadItem.receivedBytes / downloadItem.totalBytes) * 100

    title: i18n.tr("Downloading:\n" + downloadItem.downloadFileName)
    text: downloadItem.url

    Label {
        text: "Progress: " + progress + "\nReceived: " + hrrc +" Total"+ hrttl
    }
    ProgressBar {
        id: progBar
        minimumValue: 0
        maximumValue: 100
        value: progress
        height: units.gu(1)
    }
    Button {
        id: pauseButton
        visible: progress === 100 ? false : true
        text: downloadItem.isPaused ? i18n.tr("Resume") : i18n.tr("Pause")
        onClicked: downloadItem.isPaused ? downloadItem.resume() : downloadItem.pause()
    }
    Button {
        id: okButton
        text: progress === 100 ? i18n.tr("OK") : i18n.tr("Cancel")
        onClicked: {
            progress === 100 ? PopupUtils.close(downloadDialog) : downloadItem.cancel()
            PopupUtils.close(downloadDialog)
        }
    }
    Button {
        id: shareButton
        visible: progress === 100
        text: i18n.tr("Open")
        onClicked: {
            exportPeerPicker.contentType = MimeTypeMapper.mimeTypeToContentType(downloadItem.mimeType);
            exportPeerPicker.visible = true;
            exportPeerPicker.path = downloadItem.path;
            exportPeerPicker.mimeType = downloadItem.mimeType;
            exportPeerPicker.downloadUrl = downloadItem.url;
        }
    }

    ContentPeerPicker {
        id: exportPeerPicker
        visible: false
        focus: visible
        handler: ContentHandler.Destination
        property string path
        property string mimeType
        property string downloadUrl
        onPeerSelected: {
            var transfer = peer.request()
            if (transfer.state === ContentTransfer.InProgress) {
                transfer.items = [contentItemComponent.createObject(downloadsItem, {"url": path})]
                transfer.state = ContentTransfer.Charged
            }
            visible = false
        }
        onCancelPressed: visible = false
        Keys.onEscapePressed: visible = false
    }

    Component.onCompleted: {
        hrttl = JS.humanFileSize(downloadItem.totalBytes)
    }
}
