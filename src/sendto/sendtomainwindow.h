#ifndef SENDTOMAINWINDOW_H
#define SENDTOMAINWINDOW_H

#include <QMainWindow>
#include <QStringListModel>
#include <QItemSelection>

namespace Ui {
class SendToMainWindow;
}

class SendToMainWindow : public QMainWindow
{
    Q_OBJECT

public:
    SendToMainWindow(int argc, char *argv[], const QString &);
    ~SendToMainWindow();

private slots:

    void okPressed();
    void cancelPressed();
    void mySelectionChanged(const QItemSelection &,const QItemSelection &);
private:
    int argc;
    char **argv;
    QString vaultDir;
    QString selectedFile;
    Ui::SendToMainWindow *ui;
    QStringListModel *model;
};

#endif // SENDTOMAINWINDOW_H
