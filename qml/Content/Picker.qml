/*
 * Copyright 2014-2016 Canonical Ltd.
 *
 * This file is part of morph-browser.
 *
 * morph-browser is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * morph-browser is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Content 1.3
import "MimeTypeMapper.js" as MimeTypeMapper
import "../Dialogs/"

Page {
    id: picker
    property var handler
    property var contentType

    ContentPeerPicker {
        anchors { fill: parent; topMargin: picker.header.height }
        visible: parent.visible
        showTitle: true
        contentType: picker.contentType
        handler: picker.handler

        onPeerSelected: {
            peer.selectionType = ContentTransfer.Single
            picker.activeTransfer = peer.request()
            picker.activeTransfer.stateChanged.connect(function() {
				if (picker.activeTransfer.state === ContentTransfer.InProgress) {
					console.log("In progress");
					picker.activeTransfer.items = picker.activeTransfer.items[0].url = url;
					picker.activeTransfer.state = ContentTransfer.Charged;
				}
                if (picker.activeTransfer.state === ContentTransfer.Charged) {
					console.log("Charged");
                    picker.imported(picker.activeTransfer.items[0].url)
					console.log(picker.activeTransfer.items[0].url)
                    picker.activeTransfer = null
                }
            })
        }
        onCancelPressed: {
                pageStack.pop()
            }
    }

    ContentTransferHint {
        id: transferHint
        anchors.fill: parent
        activeTransfer: picker.activeTransfer
    }
    Component {
        id: resultComponent
        ContentItem {}
    }
}