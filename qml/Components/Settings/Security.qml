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
        // ==== SECURITY CATEGORY ====
        ListItem {
            ListItemLayout {
                title.text: i18n.tr("Enable JavaScript:")
                subtitle.text: i18n.tr("A major security feature, it will break many websites")
                // TODO: Cannot assign a value directly to a grouped property
                //subtitle.text.wrapMode: Text.Wrap
            }
            Switch {
                id: jsswitch
                anchors {
                    top: parent.top; topMargin: column.mSpacing
                    right: parent.right; rightMargin: units.gu(1)
                }
                checked: prefs.js
            }
        }
        ListItem {
            ListItemLayout {
                title.text: i18n.tr("Autoload Images:")
                subtitle.text: i18n.tr("By disabling, images will not be loaded")
            }
            Switch {
                id: imagswitch
                anchors {
                    top: parent.top; topMargin: column.mSpacing
                    right: parent.right; rightMargin: units.gu(1)
                }
                checked: prefs.loadimages
            }
        }
        ListItem {
            ListItemLayout {
                title.text: i18n.tr("Block autoplay:")
                subtitle.text: i18n.tr("Block videos from automatically playing")
            }
            Switch {
                id: playswitch
                anchors {
                    top: parent.top; topMargin: column.mSpacing
                    right: parent.right; rightMargin: units.gu(1)
                }
                checked: prefs.autoplay
            }
        }
        ListItem {
            ListItemLayout {
                title.text: i18n.tr("Allow running insecure content:")
                subtitle.text: i18n.tr("Allows loading files over unencrypted HTTP")
            }
            Switch {
                id: insecswitch
                anchors {
                    top: parent.top; topMargin: column.mSpacing
                    right: parent.right; rightMargin: units.gu(1)
                }
                checked: prefs.securecontent
            }
        }
	}
    Component.onDestruction: {
	    prefs.loadimages = imagswitch.checked
	    prefs.securecontent = insecswitch.checked
        prefs.js = jsswitch
	    prefs.autoplay = playswitch.checked
    }
}
