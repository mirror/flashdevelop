#include <QDebug>
#include "mainwindow.h"
#include "ui_mainwindow.h"

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);

    server = new BridgeServer(parent);
}

MainWindow::~MainWindow()
{
    //server->close();
    //delete server;
    delete ui;
}
