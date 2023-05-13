
import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3
import Ubuntu.DownloadManager 1.2

Dialog {
    id: downloadDialog

    property string dialogTitle: i18n.tr("Downloading:") // Title of the dialog
    property url url: "" 				// Explanation (under title)

    title: dialogTitle
    text: url

    SingleDownload {
        id: single
    }
	Column {
		height: cancelButton.height + progBar.height + units.gu(4)

    	Button {
			id: cancelButton
    	    text: single.progress === 100 ? i18n.tr("OK") : i18n.tr("Cancel")
    	    onClicked: {
				single.progress === 100 ? PopupUtils.close(downloadDialog) : single.cancel()
    	        PopupUtils.close(downloadDialog)
    	    }
			//anchors.horizontalCenter: Qt.AlignHCenter
    	}
    	ProgressBar {
			id: progBar
    	    minimumValue: 0
    	    maximumValue: 100
    	    value: single.progress
    	    height: units.gu(1)
    	    anchors {
    	        left: parent.left
    	        right: parent.right
    	        bottom: parent.bottom
    	    }
    	}
	}
	Component.onCompleted: single.download(url)
}