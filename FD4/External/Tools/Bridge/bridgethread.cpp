#include <QtNetwork>
#include <QDebug>
#include "bridgethread.h"

#define EOL "*"

BridgeThread::BridgeThread(int descriptor, QObject *parent) : QThread(parent)
{
    socketDescriptor = descriptor;
    handler = 0;
}

void BridgeThread::run()
{
    QTcpSocket client;
    if (!client.setSocketDescriptor(socketDescriptor)) {
        //emit error(client.error());
        qDebug() << "Socket init error:" << client.errorString();
        return;
    }

    while (isRunning())
    {
        if (client.waitForReadyRead(0))
        {
            QString msg(client.readLine().trimmed());
            //qDebug() << "in:" << msg;
            QStringList params = msg.split(':', QString::KeepEmptyParts);
            QString cmd(params[0]);
            emit command(cmd, params[1]);
            if (cmd == "close" || cmd == "unwatch") break;
        }
        if (queue.length() > 0)
        {
            mutex.lock();
            foreach(QString message, queue)
            {
                qDebug() << "send" << message;
                client.write(message.toUtf8());
                client.write(EOL);
            }
            client.flush();
            queue.clear();
            mutex.unlock();
        }
        msleep(100);
    }
}

void BridgeThread::sendMessage(QString message)
{
    mutex.lock();
    if (!queue.contains(message))
        queue << message;
    mutex.unlock();
}


/* COMMANDS HANDLING */

BridgeHandler::BridgeHandler(QObject *parent) : QObject(parent)
{
    fsw = 0;
    useCount = 0;
    isSpecial = false;
}

BridgeHandler::~BridgeHandler()
{
    if (fsw != 0)
    {
        qDebug() << "dispose handler";
        delete fsw;
    }
}

void BridgeHandler::command(QString name, QString param)
{
    if (name == "watch") watchPath(param);
}

void BridgeHandler::watchPath(QString param)
{
    watched = param;

    QStringList hasFilter(param.split('*'));
    if (hasFilter.length() > 1)
    {
        filter << "*" + hasFilter[1];
        remotePath = hasFilter[0].replace('\\', '/');
    }
    else remotePath = param.replace('\\', '/');

    localPath = getLocalPath(remotePath);

    bool isDir = localPath.endsWith('/');
    if (isDir)
    {
        remotePath.chop(1);
        localPath.chop(1);
    }

    watchedPath = localPath;
    qDebug() << "watch" << watchedPath << filter << isSpecial;

    fsw = new FileSystemWatcherEx(this);
    connect(fsw, SIGNAL(fileSystemChanged(QString)), this, SLOT(localChanged(QString)));

    if (isSpecial)
    {
        watchedPath = getSpecialPath();
        fsw->setPath(watchedPath, false);
    }
    else if (isDir) fsw->setPath(watchedPath, true);
    else fsw->setFile(watchedPath);
}

QString BridgeHandler::getSpecialPath()
{
    QString path("");
    if (special == "flashide")
    {
        path = QDir::home().absolutePath() + "/Library/Application Support/Adobe/FlashDevelop/";
        QDir().mkpath(path);
    }
    return path;
}

QString BridgeHandler::getLocalPath(QString path)
{
    QString local = "";
    QRegExp rePath("//([^/]+)/([^/]+)/(.*)");

    if (path.startsWith("//"))
    {
        if (rePath.indexIn(path) >= 0)
        {
            QString root("/Users/pelsass/");
            //QString machine(rePath.cap(1));
            QString folder(rePath.cap(2));
            QString rest(rePath.cap(3));
            local = root + folder + "/" + rest;
        }
    }
    else local = path;

    if (local.contains(".FlashDevelop"))
    {
        special = QDir(local).dirName();
        isSpecial = true;
        qDebug() << "special:" << special;
    }
    return local;
}

QString BridgeHandler::getRemotePath(QString path)
{
    if (isSpecial)
    {
        return remotePath;
    }
    else
    {
        int len = localPath.length();
        if (path.length() < len) return "";
        return remotePath + path.mid(len);
    }
}

void BridgeHandler::localChanged(QString path)
{
    if (isSpecial) // copy in shared space
    {
        QDir dir(path);
        dir.setNameFilters(filter);
        QStringList files(dir.entryList());
        if (files.length() == 0)
            return; // no file matches filter

        foreach(QString name, files)
        {
            QFile file(path + name);
            if (file.exists())
                file.copy(localPath + "/" + name);
        }
        path = localPath;
    }

    qDebug() << "changed" << path;
    path = getRemotePath(path);
    qDebug() << "local=" << path;
    if (path.length() > 0)
    {
        qDebug() << "changed" << path;
        emit notifyChanged(path);
    }
}
