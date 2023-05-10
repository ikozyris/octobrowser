import Ubuntu.Components 1.3
import QtWebEngine 1.11
import QtQuick 2.12

WebEngineView {
    id: webview
    visible: MyTabs.tabVisibility
    url: MyTabs.currtab
    zoomFactor: preferences.zoomlevel / 100                    // custom zoom factor

    settings {
        javascriptEnabled: preferences.js                      // enable javascipt
        autoLoadImages: preferences.loadimages                 // autoload images
        webRTCPublicInterfacesOnly: preferences.webrtc         // setting to true creates leaks
        pluginsEnabled: true                                   // workaround for pdf
        playbackRequiresUserGesture: preferences.autoplay      // autoplay video
        pdfViewerEnabled: true                                 // enable pdf viewer
        showScrollBars: false                                  // do not show scroll bars
        allowRunningInsecureContent: preferences.securecontent // InSecure content
        fullScreenSupportEnabled: true
        dnsPrefetchEnabled: true
        touchIconsEnabled: true
    }
    profile: webViewProfile
    onFullScreenRequested: function(request) {
        if (request.toggleOn) {
            pageHeader.visible = false;
            webview.state = "fullscreen";
            window.showFullScreen();
        } else {
            window.showNormal();
            webview.state = barposition;
            pageHeader.visible = true;
        }
        request.accept();
    }
    onLoadingChanged: {
        if(loadRequest.errorString)
            console.error(loadRequest.errorString)
        else {
            history.urls.push(webview.url)
            history.dates.push(new Date())
            history.count = history.count + 1
        }
    }
    backgroundColor: "grey"
}
