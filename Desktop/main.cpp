#include <QGuiApplication>
#include <QtQuick/QQuickView>
#include <QtWidgets/QApplication>
#include <QtCore/QDir>
#include <QQmlApplicationEngine>

#include "./io.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    qmlRegisterType<IOout>("IO", 1, 0, "IOout");

    QApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
