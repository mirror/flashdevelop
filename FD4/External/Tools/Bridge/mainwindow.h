#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QtGui>
#include "bridgeserver.h"
#include "filesystemwatcherex.h"

namespace Ui {
    class MainWindow;
}

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    explicit MainWindow(QWidget *parent = 0);
    ~MainWindow();

private slots:
    void bridgeStatus(int threads, int watchers);
    void on_btAdd_clicked();
    void on_btRemove_clicked();
    void on_listMap_itemSelectionChanged();
    void on_listMap_cellChanged(int row, int column);

private:
    Ui::MainWindow *ui;
    BridgeServer *server;
    bool lockSettings;

    QLabel *statusLabel;
    QStatusBar *statusBar;

    void initStatusBar();
    void initMapping();
    void updateSettings();
};

#endif // MAINWINDOW_H
