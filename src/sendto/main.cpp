#include "sendtomainwindow.h"
#include <QApplication>
#include "configfile.h"
#include <QSettings>
#include <QDir>
#include <QNetworkAccessManager>
#include <QMessageBox>
using namespace OCC;

static const char accountsC[] = "Accounts";
static const char versionC[] = "version";

QString getVaultDropFolder() {

    auto settings = ConfigFile::settingsWithGroup(QLatin1String(accountsC));
    if (settings->status() != QSettings::NoError) {
        qDebug() << "Could not read settings from" << settings->fileName() << settings->status();
        return NULL;
    }


    foreach (const auto &accountId, settings->childGroups()) {
//        qDebug() << "Account group: " << accountId;
        settings->beginGroup(accountId);
//        if (auto acc = loadAccountHelper(*settings)) {
//            acc->_id = accountId;
//            if (auto accState = AccountState::loadFromSettings(acc, *settings)) {
//                addAccountState(accState);
//            }
//        }
        Q_FOREACH (QString key, settings->childKeys()) {
            //qDebug() << "  key: " << key << " value: " << settings->value(key);
        }

        Q_FOREACH (QString key2, settings->childGroups()) {
           // if (!key.startsWith(authTypePrefix))
             //   continue;
         //   acc->_settingsMap.insert(key, settings.value(key));
//            qDebug() << "  group: " << key2;
            settings->beginGroup(key2);


            Q_FOREACH (QString key4, settings->childGroups()) {
               // if (!key.startsWith(authTypePrefix))
                 //   continue;
             //   acc->_settingsMap.insert(key, settings.value(key));
                //qDebug() << "    group: " << key4 ;
                settings->beginGroup(key4);

                Q_FOREACH (QString key3, settings->childKeys()) {
                   // if (!key.startsWith(authTypePrefix))
                     //   continue;
                 //   acc->_settingsMap.insert(key, settings.value(key));
                    // qDebug() << "      key: " << key3 << " value: " << settings->value(key3);
                }
                qDebug() << "Local Path for Vault Drop: " << settings->value("localPath").toString() ;

                return settings->value("localPath").toString();

                //settings->endGroup();

            }


            settings->endGroup();
        }

        settings->endGroup();
    }
    return NULL;

}

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);

    //OCC::AccountManager *inst = OCC::AccountManager.instance();

    QString localPath = getVaultDropFolder();
    if (localPath == NULL) {
        QMessageBox msgBox;
        msgBox.setText("No local Vault Drop account is configured.");
        msgBox.exec();
        return -1;
    }

    SendToMainWindow w(argc, argv, localPath);
    w.show();

    return a.exec();
}
