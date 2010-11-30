#ifndef BRIDGESERVER_H
#define BRIDGESERVER_H

#include <QTcpServer>
#include <QList>
#include "bridgethread.h"

class BridgeServer : public QTcpServer
{
    Q_OBJECT

    QHash<QString, BridgeHandler*> watched;
    void releaseHandler(BridgeThread *thread);
    void openDocument(QString path);

public:
    BridgeServer(QObject *parent = 0);
    BridgeHandler *createWatchHandler(QString path);

protected:
    void incomingConnection(int socketDescriptor);

private slots:
    void command(QString cmd, QString value);
    void threadFinished();
};

#endif
