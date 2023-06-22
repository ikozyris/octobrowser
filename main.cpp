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
#include <QQuickStyle>
#include <QtWebEngine/QtWebEngine>
//#include <QtWebEngine/qtwebengineglobal.h>
#include <QStandardPaths>
#include <QSettings>

#include <iostream>
#include <stdio.h>
#include <string>
#include <sys/stat.h>

// Run with QQuickView
int main(int argc, char *argv[])
{
    // faster reading
    //std::ios_base::sync_with_stdio(false);
    //std::cin.tie(NULL);

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    //QCoreApplication::setAttribute(Qt::AA_UseOpenGLES); // Is this needed?
    QCoreApplication::setAttribute(Qt::AA_ShareOpenGLContexts);

    QGuiApplication::setOrganizationName("octobrowser.ikozyris");
    QGuiApplication::setApplicationName("octobrowser.ikozyris");

    QString appDataPath = QStandardPaths::writableLocation(QStandardPaths::AppDataLocation);
    std::string config = appDataPath.toStdString();
    std::string args = " --enable-features=OverlayScrollbar --enable-smooth-scrolling ";

    struct stat sb;
    // if path exists
    if (stat(config.c_str(), &sb) == 0) {
        //qDebug() << "path exists";
        config += "/args.conf";
        FILE *fp = fopen(config.c_str(), "r");
        char ch;
        // if file exists
        if (fp != NULL) {
            //qDebug() << "file exists";
            args.clear();
            while ((ch = getc(fp)) != EOF) {
                args += ch;
                // if unusually large file, stop reading
                if (args.length() >= 500) {
                    qDebug() << "what?!";
                    break;
                }
            }
            //qDebug() << QByteArray::fromStdString(args);
            qputenv("QTWEBENGINE_CHROMIUM_FLAGS", QByteArray::fromStdString(args));
            fclose(fp);
        } else {
            //qDebug() << "file does not exist";
            // if not initialized, set defaults
            FILE *fp = fopen(config.c_str(), "w");
            fputs(args.c_str(), fp);
            fclose(fp);
        }
    } //else qDebug() << "first start";

    qputenv("QTWEBENGINE_CHROMIUM_FLAGS", QByteArray::fromStdString(args));

    qputenv("QT_AUTO_SCREEN_SCALE_FACTOR", "true");
    qputenv("APP_ID", "ikozyris.octobrowser");
    qputenv("QTWEBENGINE_DIALOG_SET", "QtQuickControls2"); //force QQC2 popups

    if (qgetenv("QT_QPA_PLATFORM") == "wayland") {
        qputenv("QT_WAYLAND_SHELL_INTEGRATION", "wl-shell");
    }

    QGuiApplication *app = new QGuiApplication(argc, (char**)argv);
    app->setApplicationName("octobrowser.ikozyris");

    qDebug() << "Starting app from main.cpp";

    // disabled since this style has problems and
    // qqc2 components are only once used
    //QQuickStyle::setStyle("Suru"); // set style to Suru (for Ubuntu Touch)

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
