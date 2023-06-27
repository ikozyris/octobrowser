import QtQuick 2.12
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3
import Ubuntu.DownloadManager 1.2
import Ubuntu.Content 1.3

import "../Content/MimeTypeMapper.js" as MimeTypeMapper
import "/qml/Utils.js" as JS

Dialog {
    id: downloadDialog

    property var downloadItem
    property bool isPaused: false
    property var url
    property var hrttl // human readable total file size
    property var path

    function rePau() {
        if (isPaused) {
            single.resume()
            isPaused = false
        } else {
            single.pause()
            isPaused = true
        }
    }

    title: i18n.tr("Downloading:")
    text: url

    SingleDownload {
        id: single
        metadata: Metadata {
            showInIndicator: true
            title: "Downloading from Octobrowser"
        }
        onFinished: function(path) {
            downloadDialog.path = path
            //console.log(path)
        }    
    }
    Label {
        // TODO: received bytes? progress/total
        text: "Progress: " + single.progress + "\nTotal: "+ hrttl
    }
    ProgressBar {
        id: progBar
        minimumValue: 0
        maximumValue: 100
        value: single.progress
        height: units.gu(1)
    }
    Button {
        id: pauseButton
        visible: single.progress === 100 ? false : true
        text: isPaused ? i18n.tr("Resume") : i18n.tr("Pause")
        onClicked: rePau()
    }
    Button {
        id: okButton
        text: single.progress === 100 ? i18n.tr("OK") : i18n.tr("Cancel")
        onClicked: {
            single.progress === 100 ? PopupUtils.close(downloadDialog) : single.cancel()
            PopupUtils.close(downloadDialog)
        }
    }
    Button {
        id: shareButton
        visible: single.progress === 100
        text: i18n.tr("Open")
        onClicked: {
            exportPeerPicker.contentType = ContentType.Unknown //MimeTypeMapper.mimeTypeToContentType(downloadItem.mimeType);
            exportPeerPicker.visible = true;
            exportPeerPicker.path = path;
            //exportPeerPicker.mimeType = downloadItem.mimeType;
            exportPeerPicker.downloadUrl = downloadDialog.url;   
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
        url = downloadItem.url
        hrttl = JS.humanFileSize(downloadItem.totalBytes)
        single.download(url)
    }
}
