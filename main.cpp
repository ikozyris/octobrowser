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

#include <QGuiApplication>
#include <QCoreApplication>
#include <QUrl>
#include <QString>
#include <QQuickView>
//#include <QQmlApplicationEngine>
//#include <QQmlContext>
//#include <QQuickStyle>
#include <QtWebEngine/QtWebEngine>

// Run with QQuickView
int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QCoreApplication::setAttribute(Qt::AA_ShareOpenGLContexts);

    qputenv("QTWEBENGINE_CHROMIUM_FLAGS", "--blink-settings=darkMode=3,darkModeImagePolicy=2,darkModeImageStyle=2 --enable-smooth-scrolling --enable-low-res-tiling --enable-low-end-device-mode --enable-natural-scroll-default");
    qputenv("QT_AUTO_SCREEN_SCALE_FACTOR", "true");

    if (qgetenv("QT_QPA_PLATFORM") == "wayland") {
         qputenv("QT_WAYLAND_SHELL_INTEGRATION", "wl-shell");
    }
    //QtWebEngine::initialize();

    QGuiApplication *app = new QGuiApplication(argc, (char**)argv);
    app->setApplicationName("octobrowser.ikozyris");

    qDebug() << "Starting app from main.cpp";

    QQuickView *view = new QQuickView();
    view->setSource(QUrl("qrc:///qml/Main.qml"));
    view->setResizeMode(QQuickView::SizeRootObjectToView);
    view->show();

    return app->exec();
}

/*  // Run with QQmlApplicationEngine
int main(int argc, char *argv[])
{
    QGuiApplication::setApplicationName("OctoBrowser");
    QGuiApplication::setOrganizationName("octobrowser.ikozyris");
    QGuiApplication::setApplicationName("octobrowser.ikozyris");
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QCoreApplication::setAttribute(Qt::AA_ShareOpenGLContexts);

    QtWebEngine::initialize();

    QGuiApplication app(argc, argv);

    QString style = QQuickStyle::name();
    QQuickStyle::setStyle("Suru");    

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("availableStyles", QQuickStyle::availableStyles());
    engine.load(QUrl("qrc:///qml/Main.qml"));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}*/