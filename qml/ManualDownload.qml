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
    DownloadManager {
        id: manager
    }
    TextField {
        id: text
        placeholderText: "File URL to download..."
        height: 50
        anchors {
            top: header.bottom
            left: parent.left
            right: button.left
            rightMargin: units.gu(2)
        }
    }
    Button {
        id: button
        text: "Download"
        height: 50
        anchors.top: header.bottom
        anchors.right: parent.right
        onClicked: {
            manager.download(text.text);
        }
    }
    UbuntuListView {
        id: list
        anchors {
            left: parent.left
            right: parent.right
            top: text.bottom
            bottom: parent.bottom
        }
        model: manager.downloads
        delegate: Label {
            text: model.url
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
        value: manager.downloads.progress
        anchors {
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }
        minimumValue: 0
        maximumValue: 100
        height: units.gu(5)
    }
}
