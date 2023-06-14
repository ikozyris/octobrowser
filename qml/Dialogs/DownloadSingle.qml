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
    }
    Label {
        text: "Progress: " + single.progress
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
            single.progress === 100 ? PopupUtils.close(downloadDialog) : download.cancel()
            PopupUtils.close(downloadDialog)
        }
    }
    Button {
        id: shareButton
        visible: single.progress === 100
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
    Component.onCompleted: single.download(url)
}
