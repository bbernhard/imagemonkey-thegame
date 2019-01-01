#include "basicrequest.h"
#include "../settings.h"

BasicRequest::BasicRequest()
    : SslRequest(),
      m_requestId(""),
      m_jwt("")
{
    ConnectionSettings* connectionSettings = ConnectionSettings::instance();
    if(connectionSettings)
        m_baseUrl = connectionSettings->getBaseUrl();
}

void BasicRequest::setBaseUrl(const QString& baseUrl){
    m_baseUrl = baseUrl;
}

QString BasicRequest::getBaseUrl() const{
    return m_baseUrl;
}

void BasicRequest::setRequestId(const QString& requestId){
    m_requestId = requestId;
    m_request->setRawHeader(QByteArray("X-Request-Id"), QByteArray(requestId.toUtf8()));
}

QString BasicRequest::getRequestId() const{
    return m_requestId;
}

BasicRequest::BasicRequest(const QString &baseUrl, const QString& requestId)
    : SslRequest(),
      m_baseUrl(baseUrl),
      m_requestId(requestId)
{
    m_request->setRawHeader(QByteArray("X-Request-Id"), QByteArray(requestId.toUtf8()));
}

void BasicRequest::setJWT(const QString &jwt){
    m_jwt = jwt;
    m_request->setRawHeader("Authorization", "Bearer " + QByteArray(QString("%1").arg(m_jwt).toUtf8()));
}

BasicRequest::~BasicRequest(){
}
