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
 */

import QtQuick 2.9
import Lomiri.Components 1.3
import Qt.labs.settings 1.0
import "/qml/MainPage.qml" as MainPage

MainView {
    id: mainView
    objectName: 'mainView'
    applicationName: 'octobrowser.ikozyris'
    automaticOrientation: true
    anchorToKeyboard: true

    //width: units.gu(45)
    //height: units.gu(75)

    Settings {
        id: preferences
        property int zoomlevel: 100
        //property int adrpos: 1
        property string cmuseragent: "Mozilla/5.0 (Linux; Android 11) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Mobile Safari/537.36"
        property bool js: true
        property bool loadimages: true
    }

    PageStack {
        id: pStack
    }

    Component.onCompleted: {
        pStack.push(Qt.resolvedUrl("MainPage.qml"));
    }

    function showSettings() {
        var prop = {
            zoomlevel: preferences.zoomlevel,
            //adrpos: preferences.adrpos,
            cmuseragent: preferences.cmuseragent,
            js: preferences.js,
            loadimages: preferences.loadimages
        }

        var slot_applyChanges = function(msettings) {
            console.log("Saving changes...")
            preferences.zoomlevel = msettings.zoomlevel;
            //preferences.adrpos = msettings.adrpos;
            preferences.cmuseragent = msettings.cmuseragent
            preferences.js = msettings.js
            preferences.loadimages = msettings.loadimages
            //MainPage.mainPage.pageHeader.state = "anchorBottom";
            //MainPage.mainPage.webview.state = "anchorBottom"
        }

        var settingPage = pStack.push(Qt.resolvedUrl("Settings.qml"), prop);

        settingPage.applyChanges.connect(function() { slot_applyChanges(settingPage) });
    }

}
