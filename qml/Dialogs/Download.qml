import QtQuick 2.12
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3
import Ubuntu.DownloadManager 1.2

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

    property url url: ""
    property bool isPaused: false

    title: i18n.tr("Downloading:")
    text: url

    SingleDownload {
        id: single
        metadata: Metadata {
            showInIndicator: true
            title: "Downloading" + url + "from Octobrowser"
        }
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
    ProgressBar {
        id: progBar
        minimumValue: 0
        maximumValue: 100
        value: single.progress
        height: units.gu(1)
    }

    Component.onCompleted: single.download(url)
}
