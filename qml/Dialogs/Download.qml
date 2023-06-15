import QtQuick 2.12
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3
import Ubuntu.DownloadManager 1.2
import Ubuntu.Content 1.3
import "../Content/MimeTypeMapper.js" as MimeTypeMapper

Dialog {
    id: downloadDialog

    function rePau() {
        if (isPaused) {
            downloadItem.resume()
            isPaused = false
        } else {
            downloadItem.pause()
            isPaused = true
        }
    }
    // workaround to inherit webengine download item
    property var downloadItem

    property bool isPaused: false
    property real progress: (downloadItem.receivedBytes / downloadItem.totalBytes) * 100

    title: i18n.tr("Downloading:\n" + downloadItem.downloadFileName)
    text: downloadItem.url

    Label {
        text: "Progress: " + progress
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
        text: isPaused ? i18n.tr("Resume") : i18n.tr("Pause")
        onClicked: rePau()
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
            /*
            exportPeerPicker.contentType = MimeTypeMapper.mimeTypeToContentType(downloadItem.mimetype);
            exportPeerPicker.visible = true;
            exportPeerPicker.path = downloadItem.path;
            exportPeerPicker.mimeType = downloadItem.mimetype;
            exportPeerPicker.downloadUrl = downloadItem.url;
            */
            contentExportLoader.item.openDialog(webViewProfile.downloadPath + downloadItem.downloadFileName, 
                MimeTypeMapper.mimeTypeToContentType(downloadItem.mimeType),
                downloadItem.mimeType, downloadItem.url, title)
            
        }
    }
}
