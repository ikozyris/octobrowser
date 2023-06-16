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

import QtQuick 2.12
import QtQuick.Layouts 1.3
import Ubuntu.Components 1.3

ScrollView {
    id: scrollView
    Column {
        id: column
        width: scrollView.width
        property int mSpacing: units.gu(2)
		// ==== PRIVACY CATEGORY ====
        ListItem {
            height: ualabel.height + uatext.height + column.mSpacing
            ListItemLayout {
                id: ualabel
                title.text: i18n.tr("User Agent:")
                subtitle.text: i18n.tr("This can be used to confuse websites about your identity and/or"
                                     + " load the desktop version of a page.")
            }
            TextArea {
                id: uatext
                maximumLineCount: 3
                width: parent.width
                anchors.top: ualabel.bottom
                text: prefs.cmuseragent
                onTextChanged: prefs.cmuseragent = uatext.text
            }
        }
        ListItem {
            ListItemLayout {
                title.text: i18n.tr("Limit WebRTC to public IP addresses only:")
                subtitle.text: i18n.tr("If enabled, it might leak your real IP, even if a VPN is used")
            }
            Switch {
                id: rtcswitch
                anchors {
                    top: parent.top; topMargin: column.mSpacing
                    right: parent.right; rightMargin: units.gu(1)
                }
                checked: prefs.webrtc
                onCheckedChanged: prefs.webrtc = rtcswitch.checked
            }
        }
	}
}
