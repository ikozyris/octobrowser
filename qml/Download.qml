import QtQuick 2.9
import Ubuntu.Components 1.3
import Ubuntu.DownloadManager 1.2

Page {
	id: downloadsPage

	header: PageHeader {
		anchors.top: parent.top
		title: i18n.tr("Downloads")
	}
    TextField {
        id: text
        placeholderText: "File URL to download..."
        height: 50
        anchors {
			top: downloadsPage.header.bottom
            left: parent.left
            right: button.left
            rightMargin: units.gu(2)
        }
    }
    Button {
        id: button
        text: "Download"
        height: 50
        anchors.right: parent.right
		anchors.top: downloadsPage.header.bottom
        onClicked: {
            single.download(text.text);
        }
    }
    ProgressBar {
        minimumValue: 0
        maximumValue: 100
        value: single.progress
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        SingleDownload {
            id: single
        }
    }
}
