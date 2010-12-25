#include <QDebug>
#include <QDir>
#include <QSettings>
#include "mainwindow.h"
#include "ui_mainwindow.h"

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);

    initStatusBar();
    initMapping();

    server = new BridgeServer(parent);
    connect(server, SIGNAL(bridgeStatus(int,int)), this, SLOT(bridgeStatus(int,int)));
}

MainWindow::~MainWindow()
{
    delete server;
    delete ui;
}

void MainWindow::initStatusBar()
{
    statusLabel = new QLabel();
    statusLabel->setContentsMargins(10, 0,0,0);
    statusBar = new QStatusBar();
    statusBar->addWidget(statusLabel, 1);
    setStatusBar(statusBar);
}

void MainWindow::bridgeStatus(int threads, int watchers)
{
    QString msg = QString("Running: %1 threads, %2 watchers").arg(threads).arg(watchers);
    statusLabel->setText(msg);
}


/* LOCAL REMOTE MAPPING EDITION */

void MainWindow::initMapping()
{
    lockSettings = true;
    QCoreApplication::setApplicationName("Bridge");
    QCoreApplication::setOrganizationDomain("flashdevelop.org");
    QCoreApplication::setOrganizationName("FlashDevelop");

    QSettings settings;
    settings.beginGroup("localRemoteMap");
    QStringList map = settings.allKeys();
    if (map.length() == 0)
    {
        // VirtualBox: \\VBOXSVR\xxx
        // Parallels: \\.PSF\xxx
        // VMWare: \\.HOST\Shared Folders\xxx
        settings.setValue("VBOXSVR/Dev", QDir::homePath() + "/Dev");
        settings.endGroup();
        settings.beginGroup("localRemoteMap");
        map = settings.allKeys();
    }

    ui->listMap->setRowCount(map.length());

    int line = 0;
    foreach(QString key, map)
    {
        QTableWidgetItem *item = new QTableWidgetItem(QString("//" + key).replace("/", "\\"));
        ui->listMap->setItem(line, 0, item);
        item = new QTableWidgetItem(settings.value(key).toString());
        ui->listMap->setItem(line, 1, item);
        line++;
    }

    ui->btRemove->setEnabled(false);
    lockSettings = false;

    updateSettings(); // validate entries
}

void MainWindow::on_btAdd_clicked()
{
    QTableWidgetItem *item;
    int line = ui->listMap->rowCount();
    // already one empty line?
    if (line > 0)
    {
        item = ui->listMap->item(line-1, 0);
        if (item->text().isEmpty() && ui->listMap->item(line-1, 1)->text().isEmpty())
        {
            ui->listMap->setCurrentItem(item);
            ui->listMap->editItem(item);
            return;
        }
    }
    // new line
    lockSettings = true;
    ui->listMap->setRowCount(line + 1);
    item = new QTableWidgetItem("");
    ui->listMap->setItem(line, 1, item);
    item = new QTableWidgetItem("");
    ui->listMap->setItem(line, 0, item);
    ui->listMap->setCurrentItem(item);
    ui->listMap->editItem(item);
    lockSettings = false;
}

void MainWindow::on_btRemove_clicked()
{
    int line = ui->listMap->currentRow();
    if (line >= 0)
    {
        ui->listMap->removeRow(line);
        updateSettings();
    }
}

void MainWindow::on_listMap_itemSelectionChanged()
{
    bool active = ui->listMap->currentItem() && ui->listMap->currentItem()->isSelected();
    ui->btRemove->setEnabled(active);
}

void MainWindow::on_listMap_cellChanged(int row, int column)
{
    updateSettings();
}

void MainWindow::updateSettings()
{
    if (lockSettings) return;
    QSettings settings;
    settings.beginGroup("localRemoteMap");

    // clear
    foreach(QString key, settings.allKeys()) settings.remove(key);

    // populate from valid lines in grid
    QColor error(QColor::fromRgb(0xff, 0xcc, 0x66));
    QColor valid(ui->listMap->palette().base().color());

    int lines = ui->listMap->rowCount();
    QRegExp reRemote("//([^/]+)/(.+)");
    for (int i = 0; i < lines; ++i)
    {
        QTableWidgetItem *item = ui->listMap->item(i, 0);
        QString remote(item->text());
        bool remoteValid = false;
        if (!remote.isEmpty())
        {
            remote = remote.replace("\\", "/");
            if (reRemote.indexIn(remote) < 0)
            {
                // invalide remote path
                item->setBackgroundColor(error);
                item->setToolTip("Path doesn't match \\\\MACHINE_NAME\\folder_name");
            }
            else
            {
                remote = reRemote.cap(1) + "/" + reRemote.cap(2);
                item->setBackgroundColor(valid);
                item->setToolTip("");
                remoteValid = true;
            }
        }

        item = ui->listMap->item(i, 1);
        QString local(item->text());
        bool localValid = false;
        if (!local.isEmpty())
        {
            if (!QDir(local).exists())
            {
                // invalid local path
                item->setBackgroundColor(error);
                item->setToolTip("Path doesn't seem to exist on this computer");
            }
            else
            {
                item->setBackgroundColor(valid);
                item->setToolTip("");
                localValid = true;
            }
        }

        if (remoteValid && localValid)
            settings.setValue(remote, local);
    }
}
