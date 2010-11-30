#ifndef BRIDGETHREAD_H
#define BRIDGETHREAD_H

#include <QThread>
#include <QTcpSocket>
#include <QMutex>
#include <QStringList>
#include "filesystemwatcherex.h"

class BridgeHandler : public QObject
{
    Q_OBJECT

    QString remotePath;
    QStringList filter;
    bool isSpecial;
    QString special;
    QString localPath;
    QString watchedPath;
    FileSystemWatcherEx *fsw;

    void watchPath(QString param);
    QString getSpecialPath();
    QString getRemotePath(QString path);

public:
    BridgeHandler(QObject *parent = 0);
    ~BridgeHandler();
    QString watched;
    int useCount;

    QString getLocalPath(QString path);

signals:
    void notifyChanged(QString path);

public slots:
    void command(QString name, QString param);

private slots:
    void localChanged(QString localPath);
};


class BridgeThread : public QThread
{
    Q_OBJECT

    int socketDescriptor;
    QStringList queue;
    QMutex mutex;

public:
    BridgeThread(int descriptor, QObject *parent);
    BridgeHandler *handler;

signals:
    void command(QString name, QString param);

public slots:
    void sendMessage(QString message);

protected:
    void run();
};

#endif
