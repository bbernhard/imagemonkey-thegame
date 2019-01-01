#ifndef OSXKEYCHAIN_H
#define OSXKEYCHAIN_H

#include <QString>
#include <QImage>
#include <QQmlEngine>
#include <QSettings>
#include "../keychaininterface.h"

namespace osx {
    class KeyChain : public KeyChainInterface{
        Q_OBJECT
    public:
        KeyChain(QObject* parent = 0);
        Q_INVOKABLE void setJwt(const QString& jwt);
        Q_INVOKABLE QString getJwt() const;
        ~KeyChain();
    private:
        QSettings m_settings;
        QString m_jwt;

        void set(const QString& key, const QString& value);
        QString get(const QString& key) const;

    };
}


#endif // OSXKEYCHAIN_H
