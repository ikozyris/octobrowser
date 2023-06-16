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

Page {
    id: settingPage

    header: PageHeader {
        title: i18n.tr("Settings")
        leadingActionBar {
            actions: Action {
                iconName: "back"
                onTriggered: pStack.pop()
            }
        }
        extension: Sections {
            id: sections
            model: ["General", "Privacy", "Security", "Advanced"]
        }
    }

    Loader {
        id: generalSettingsLoader
        visible: sections.selectedIndex === 0
        asynchronous: true
        source: Qt.resolvedUrl("/qml/Components/Settings/General.qml")
        anchors {
            top: settingPage.header.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
    }
    Loader {
        id: privacySettingsLoader
        visible: sections.selectedIndex === 1
        asynchronous: true
        source: Qt.resolvedUrl("/qml/Components/Settings/Privacy.qml")
        anchors {
            top: settingPage.header.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
    }
    Loader {
        id: securitySettingsLoader
        visible: sections.selectedIndex === 2
        asynchronous: true
        source: Qt.resolvedUrl("/qml/Components/Settings/Security.qml")
        anchors {
            top: settingPage.header.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
    }
    Loader {
        id: advancedSettingsLoader
        active: sections.selectedIndex === 3
        asynchronous: true
        source: Qt.resolvedUrl("/qml/Components/Settings/Advanced.qml")
        anchors {
            top: settingPage.header.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
    }
    Loader {
        id: settingsLoader
        visible: sections.selectedIndex === 0
        asynchronous: true
        source: Qt.resolvedUrl("/qml/Components/Settings/General.qml")
        anchors {
            top: settingPage.header.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
    }
}
