
import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3

import DownloadInterceptor 1.0

Dialog {
    id: downloadDialog
    property Page page
    property string dialogTitle: i18n.tr("Download") 			// Title of the dialog
    property string descriptionPrepend: i18n.tr("Download:") 	// Explanation (under title)
    
    title: dialogTitle
    text: descriptionPrepend

    ProgressBar {
		id: downloadBar
		height: units.dp(3)
		anchors {
			left: parent.left
			right: parent.right
		}

		showProgressPercentage: false
		minimumValue: 0
		maximumValue: 100
	}
    
    //TO DO: Implement a cancel to the download
    
    Button {
		id: cancelButton
		visible: true
        text: i18n.tr("Cancel")
        onClicked: {
			cancelButton.text === i18n.tr("Close") ? console.log("We had an error. No need to abort") : console.log("Abort"); DownloadInterceptor.abort();
            console.log("Closing popup")
            PopupUtils.close(downloadDialog)
        }
    }
        
    Connections {
		target: DownloadInterceptor
		
		onDownloading: {
			downloadBar.value = (received * 100) / total
		}
		
		onFail: {
			//Something went wrong and the `message` argument will tell you what it was.
			
			console.log("Error: " + message)
			cancelButton.visible = true
			cancelButton.text = i18n.tr("Close")
			downloadDialog.text = message
		}
	}

}