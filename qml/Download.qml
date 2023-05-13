/*
 * Copyright (C) 2023  ikozyris
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * octobrowser is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 * 
 * this file is part of Octopus Browser (octobrowser)
 */

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
    Label {
        text: "This page exists to manually download a url, in case downloading does not work. \n" +
              "The download location (xenial 16.04) is:\n /home/phablet/.local/share/ubuntu-download-manager/octobrowser.ikozyris/Downloads"
        wrapMode: Text.Wrap
        anchors.centerIn: parent
        width: parent.width
    }
    ProgressBar {
        minimumValue: 0
        maximumValue: 100
        value: single.progress
        height: units.gu(2)
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
