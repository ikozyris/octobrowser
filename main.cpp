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

#include <QGuiApplication>
#include <QCoreApplication>
#include <QUrl>
#include <QString>
#include <QQuickView>               // QQview
//#include <QQmlApplicationEngine>  // QQengine
//#include <QQmlContext>            //  >>
//#include <QQuickStyle>            //  >>
//#include <QtWebEngine/QtWebEngine>
#include <QtWebEngine/qtwebengineglobal.h>
#include <QStandardPaths>

// Run with QQuickView
int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QCoreApplication::setAttribute(Qt::AA_UseOpenGLES);
    QCoreApplication::setAttribute(Qt::AA_ShareOpenGLContexts);

    QGuiApplication::setOrganizationName("octobrowser.ikozyris");
    QGuiApplication::setApplicationName("octobrowser.ikozyris");

//"--blink-settings=darkMode=3,darkModeImagePolicy=2,darkModeImageStyle=2 --enable-smooth-scrolling --enable-low-res-tiling 
// --enable-low-end-device-mode --enable-natural-scroll-default
    // TODO: do not hard code dark mode
    qputenv("QTWEBENGINE_CHROMIUM_FLAGS", "--force-dark-mode --blink-settings=darkModeEnabled=true");
    qputenv("QT_AUTO_SCREEN_SCALE_FACTOR", "true");

    qputenv("QTWEBENGINE_DIALOG_SET", "QtQuickControls2"); //force QQC2 web popups
    
    if (qgetenv("QT_QPA_PLATFORM") == "wayland") {
        qputenv("QT_WAYLAND_SHELL_INTEGRATION", "wl-shell");
    }
    //qputenv("PERFPROFILER_PARSER_FILEPATH",TODO);
    //QtWebEngine::initialize();
    //QString configPath = QStandardPaths::writableLocation(QStandardPaths::AppConfigLocation);
    //QString cachePath = QStandardPaths::writableLocation(QStandardPaths::CacheLocation);
    //QString appDataPath = QStandardPaths::writableLocation(QStandardPaths::AppDataLocation);

    QGuiApplication *app = new QGuiApplication(argc, (char**)argv);
    app->setApplicationName("octobrowser.ikozyris");

    qDebug() << "Starting app from main.cpp";

    QQuickView *view = new QQuickView();

    view->setSource(QUrl("qrc:///qml/Main.qml"));
    view->setResizeMode(QQuickView::SizeRootObjectToView);
    view->show();

    return app->exec();
}

// Run with QQmlApplicationEngine //DO NOT USE
//QtWebEngineProcess is not killed after app is closed 
// You may see this:
// [1:19:0505/191935.727720:ERROR:address_tracker_linux.cc(214)] Could not bind NETLINK socket: Address already in use (98)
// [1:1:0505/191937.894230:ERROR:service_worker_storage.cc(1753)] Failed to delete the database: Database IO error
/*
int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_ShareOpenGLContexts);
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication::setOrganizationName("octobrowser.ikozyris");
    QGuiApplication::setApplicationName("octobrowser.ikozyris");

    //QtWebEngine::initialize();
    //QWebEngineProfile::defaultProfile()->setPersistentCookiesPolicy(QWebEngineProfile::ForcePersistentCookies);

    QGuiApplication app(argc, argv);

//    QString style = QQuickStyle::name();
//    QQuickStyle::setStyle("Suru");    

    QQmlApplicationEngine engine;
//    engine.rootContext()->setContextProperty("availableStyles", QQuickStyle::availableStyles());
    engine.load(QUrl("qrc:///qml/Main.qml"));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}*/
