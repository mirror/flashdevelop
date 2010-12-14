#include <QDebug>
#include <QDir>
#include <QProcess>

#include "bridgeserver.h"
#include "bridgethread.h"


BridgeServer::BridgeServer(QObject *parent)
 : QTcpServer(parent)
{
    QHostAddress host("127.0.0.1");
    listen(host, 8007);
    runningThreads = 0;
    qDebug() << "Server started...";
}

void BridgeServer::notifyStatus()
{
    emit bridgeStatus(runningThreads, watched.keys().count());
}

void BridgeServer::incomingConnection(int socketDescriptor)
{
    BridgeThread *thread = new BridgeThread(socketDescriptor, 0);
    connect(thread, SIGNAL(finished()), this, SLOT(threadFinished()));
    connect(thread, SIGNAL(command(QString,QString)), this, SLOT(command(QString,QString)));
    thread->start();
    runningThreads++;
    notifyStatus();
}

void BridgeServer::command(QString cmd, QString value)
{
    BridgeThread *thread = (BridgeThread*)sender();
    //qDebug() << cmd << value;

    if (cmd == "watch")
    {
        releaseHandler(thread);

        BridgeHandler *handler = createWatchHandler(value);
        handler->useCount++;
        thread->handler = handler;
        connect(handler, SIGNAL(notifyChanged(QString)), thread, SLOT(sendMessage(QString)));
    }

    else if (cmd == "unwatch") releaseHandler(thread);

    else if (cmd == "open") openDocument(value);

    else qDebug() << cmd << value;
}

void BridgeServer::openDocument(QString path)
{
    BridgeHandler handler;
    QString localPath = handler.getLocalPath(path.replace('\\', '/'));
    qDebug() << "open" << localPath;

    QFile file(localPath);
    if (file.exists()) QProcess::startDetached("open \"" + localPath + "\"");
    else qDebug() << "File not found" << path;
}

BridgeHandler* BridgeServer::createWatchHandler(QString path)
{
    BridgeHandler *handler;
    if (watched.contains(path)) handler = watched[path];
    else
    {
        handler = new BridgeHandler(this);
        handler->command("watch", path);
        watched[path] = handler;
        notifyStatus();
    }
    return handler;
}

void BridgeServer::threadFinished()
{
    BridgeThread *thread = (BridgeThread*)sender();
    //qDebug() << "disconnected" << thread;
    releaseHandler(thread);
    thread->deleteLater();
    runningThreads--;
    notifyStatus();
}

void BridgeServer::releaseHandler(BridgeThread *thread)
{
    if (thread->handler != 0)
    {
        disconnect(thread->handler, SIGNAL(notifyChanged(QString)), thread, SLOT(sendMessage(QString)));

        if (--thread->handler->useCount <= 0)
            watched.remove(thread->handler->watched);
        thread->handler = 0;
    }
}
