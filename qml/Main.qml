import QtQuick 2.9
import Ubuntu.Components 1.3
import Qt.labs.settings 1.0

MainView {
    id: mainView
    objectName: 'mainView'
    applicationName: 'octobrowser.ikozyris'
    automaticOrientation: true

    width: units.gu(45)
    height: units.gu(75)

    Settings {
        id: preferences
        property int zoomlevel: 100
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
        }

        var slot_applyChanges = function(msettings) {
            console.log("Save changes...")
            preferences.zoomlevel = msettings.zoomlevel;
        }

        var settingPage = pStack.push(Qt.resolvedUrl("Settings.qml"), prop);

        settingPage.applyChanges.connect(function() { slot_applyChanges(settingPage) });
    }

}