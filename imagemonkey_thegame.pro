QT += qml quick quickcontrols2

#ANDROID_ABIS="arm64-v8a armeabi-v7a x86_64 x86"
#ANDROID_ABIS=armeabi-v7a

android {
    # https://bugreports.qt.io/browse/QTBUG-76293
    !versionAtLeast(QT_VERSION, "5.14.0"): QMAKE_LFLAGS += -nostdlib++

    #include (./ext/libraries/android/android_openssl/openssl.pri)
}

android{
    Qt += androidextras
}

#LOCAL, TEST, PRODUCTION
_EXECUTIONTARGET_ = "TEST"

QT_executiontarget = "$${LITERAL_HASH}ifndef __EXECUTIONTARGET__H__"
QT_executiontarget += "$${LITERAL_HASH}define __EXECUTIONTARGET__H__"
QT_executiontarget += "$${LITERAL_HASH}define EXECUTIONTARGET ExcecutionTarget::$$_EXECUTIONTARGET_"
QT_executiontarget += "$${LITERAL_HASH}endif"
write_file($$PWD/source/cpp/executiontarget.h, QT_executiontarget)

include (./ext/quicknative/quicknative.pri)

CONFIG += c++11
CONFIG += resources_big #otherwise compiling failes with "compiler is out of heap space"
CONFIG += qtquickcompiler

SOURCES += \
    source/cpp/main.cpp \
    source/cpp/rest/httpsrequestworker.cpp \
    source/cpp/rest/settings.cpp \
    source/cpp/misc/uid.cpp \
    source/cpp/rest/requests/sslrequest.cpp \
    source/cpp/rest/requests/basicrequest.cpp \
    source/cpp/rest/requests/loginrequest.cpp \
    source/cpp/models/tasksmodel.cpp \
    source/cpp/misc/imageprocessor.cpp \
    source/cpp/misc/file.cpp \
    source/cpp/rest/requests/donate.cpp \
    source/cpp/misc/base64imageprovider.cpp \
    source/cpp/rest/requests/tasksrequest.cpp \
    source/cpp/rest/requests/statsrequest.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

INCLUDEPATH += .

# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    source/cpp/rest/httpsrequestworker.h \
    source/cpp/rest/settings.h \
    source/cpp/misc/uid.h \
    source/cpp/executiontarget.h \
    source/cpp/executiontargetdef.h \
    source/cpp/main.h \
    source/cpp/rest/requests/sslrequest.h \
    source/cpp/rest/requests/basicrequest.h \
    source/cpp/rest/requests/loginrequest.h \
    source/cpp/models/tasksmodel.h \
    source/cpp/misc/imageprocessor.h \
    source/cpp/misc/file.h \
    source/cpp/rest/requests/donate.h \
    source/cpp/misc/base64imageprovider.h \
    source/cpp/rest/requests/tasksrequest.h \
    source/cpp/misc/keychaininterface.h \
    source/cpp/rest/requests/statsrequest.h

android{
    ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

    ANDROID_JAVA_SOURCES.path = /src/io/imagemonkey/thegame
    ANDROID_JAVA_SOURCES.files = $$files($$PWD/source/java/*.java)
    INSTALLS += ANDROID_JAVA_SOURCES

    HEADERS += source/cpp/misc/android/keychain.h

    SOURCES += source/cpp/misc/android/keychain.cpp
}

ios {
    HEADERS +=  source/cpp/misc/ios/keychain.h \
                source/cpp/misc/ios/keychainimpl.h

    OBJECTIVE_SOURCES += source/cpp/misc/ios/keychain.mm \
                         source/cpp/misc/ios/keychainimpl.mm
}

osx{
    HEADERS += source/cpp/misc/osx/keychain.h

    SOURCES += source/cpp/misc/osx/keychain.cpp
}

windows{
    HEADERS += source/cpp/misc/windows/keychain.h

    SOURCES += source/cpp/misc/windows/keychain.cpp
}

linux:!android{
    HEADERS += source/cpp/misc/linux/keychain.h
    SOURCES += source/cpp/misc/linux/keychain.cpp
}

contains(ANDROID_TARGET_ARCH,armeabi-v7a) {
    ANDROID_EXTRA_LIBS = \
        $$PWD/ext/libraries/android/openssl/openssl1.0.2t/armeabi-v7a/libcrypto.so \
        $$PWD/ext/libraries/android/openssl/openssl1.0.2t/armeabi-v7a/libssl.so
}

contains(ANDROID_TARGET_ARCH,arm64-v8a) {
    ANDROID_EXTRA_LIBS = \
        $$PWD/ext/libraries/android/openssl/openssl1.0.2t/aarch64/libcrypto.so \
        $$PWD/ext/libraries/android/openssl/openssl1.0.2t/aarch64/libssl.so
}


DISTFILES += \
    android/AndroidManifest.xml \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradlew \
    android/res/values/libs.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew.bat \
    source/qml/items/LoginItem.qml \
    source/qml/items/CameraItem.qml \
    source/qml/items/CameraItem.qml \
    source/qml/items/CameraItem.qml \
    source/qml/items/TasksItem.qml
