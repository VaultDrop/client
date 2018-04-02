/** Vauld Drop SendTo Widow. */

#include "sendtomainwindow.h"
#include "ui_sendtomainwindow.h"

#include <QDir>
#include <QDirIterator>
#include <QFileSystemModel>
#include <QMessageBox>
#include <QDebug>
#include <QMessageBox>

SendToMainWindow::SendToMainWindow(int argc, char **argv, const QString &vaultDir) :
    argc(argc), argv(argv),
    QMainWindow(0),
    vaultDir(vaultDir + (vaultDir.endsWith("/") || vaultDir.endsWith("\\") ? "" : "/")),
    ui(new Ui::SendToMainWindow)
{
    ui->setupUi(this);

    QStringList vaults;

    ui->pushButtonSendTo->setEnabled(false);

    QFileSystemModel *model = new QFileSystemModel;
    model->setRootPath(vaultDir);
    model->setFilter( QDir::NoDotAndDotDot | QDir::AllDirs);
    model->setRootPath(QDir::currentPath());
    ui->folderTree->header()->hide();

    ui->folderTree->setModel(model);
    ui->folderTree->setRootIndex(model->index(vaultDir));
    ui->folderTree->hideColumn(1);
    ui->folderTree->hideColumn(2);
    ui->folderTree->hideColumn(3);

    if (argc == 2) {
        QFileInfo fi(argv[1]);
        ui->itemLabel->setText("<html><head/><body><p>"+fi.fileName() +" in folder<br/>"+fi.dir().absolutePath()+"</p></body></html>");
    } else {
        QFileInfo fi(argv[1]);
        ui->itemLabel->setText("<html><head/><body><p>"+QString::number(argc-1)+" files in folder<br/>"+fi.dir().absolutePath()+"</p></body></html>");
    }


    connect(ui->folderTree->selectionModel(), SIGNAL(selectionChanged(const QItemSelection&,const QItemSelection&)), this, SLOT(mySelectionChanged(const QItemSelection&,const QItemSelection&)));

    connect(ui->pushButtonSendTo, SIGNAL (released()),this, SLOT (okPressed()));
    connect(ui->pushButtonCancel, SIGNAL (released()),this, SLOT (cancelPressed()));

}

void SendToMainWindow::okPressed() {
    if (ui->folderTree->selectionModel()->selectedIndexes().isEmpty()) {
        qDebug() << "Empty Selection Should Be Impossible.";
    } else {
        QModelIndex index = ui->folderTree->selectionModel()->currentIndex();
        QVariant data = ui->folderTree->selectionModel()->model()->data(index);
        QString text = data.toString();

        for (int a=1; a < argc; a++) {
            QLatin1String fileName(argv[a]);

            QFileInfo src(fileName);
            QFileInfo dest(vaultDir+text+"/"+src.fileName());

            //qDebug() << "SRC: " << src << "DEST: " << dest;

            for (int i = 1; i < 1000;++i) {
                if (!dest.exists())
                    break;

                //qDebug() << "SRC: " << src << "DDEST: " << dest;
                dest = QFileInfo(dest.dir(), QString("%1 %2.%3").arg(src.baseName(), QString::number(i), src.suffix()));
            }

            qDebug() << "Sending to Vault Drop: copy  " << fileName << " to " << dest.absoluteFilePath() ;
            if (dest.exists()) {
                QMessageBox msgBox;
                msgBox.setText("File already exists at the destination! Not copied.");
                msgBox.exec();
            } else {
                if (QFile::copy(fileName, dest.absoluteFilePath())) {
                    qDebug() << "Copied ok.";
                } else {
                    QMessageBox msgBox;
                    msgBox.setText(QString("Copy failed (permissions?)"));
                    msgBox.exec();

                    qDebug() << "Copy failed.";
                }
            }
        }
    }
    this->close();
}
void SendToMainWindow::cancelPressed() {

    this->close();
}

void SendToMainWindow::mySelectionChanged(const QItemSelection &selected,const QItemSelection &) {
//    qDebug() << "Selection Changed: " << selected.empty();

    if (selected.isEmpty()) {
        selectedFile = QString();
        ui->pushButtonSendTo->setEnabled(false);
    } else {
        ui->pushButtonSendTo->setEnabled(true);
    }
}

SendToMainWindow::~SendToMainWindow()
{
    delete ui;
}
