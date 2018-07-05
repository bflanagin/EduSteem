#ifndef MYIO_H
#define MYIO_H

#include <QObject>
#include <QDir>
#include <QFile>
#include <QStandardPaths>
#include <QCryptographicHash>
#include <QNetworkAccessManager>
#include <QProcess>
#include <QImage>
#include <QBuffer>
#include <QDebug>




class MyIOout : public QObject
{
    Q_OBJECT
    Q_PROPERTY( QString store READ store WRITE file NOTIFY filesaved )
    Q_PROPERTY( QString create READ create WRITE directory NOTIFY filesaved )
    Q_PROPERTY( QString send READ send WRITE upload NOTIFY filesaved )
    Q_PROPERTY( QString image READ image WRITE image_make NOTIFY filesaved )


public:
    explicit MyIOout(QObject *parent = 0);
    ~MyIOout();


Q_SIGNALS:
    void filesaved();

protected:

    QString store() {return m_message; }
    QString create() {return m_message; }
    QString send() {return m_message; }
    QString image() {return the_image; }


    void file(QString msg) {

        QString home = QDir::homePath();
        QString data = QStandardPaths::writableLocation(QStandardPaths::DataLocation);

            QDir things(data);
                QString direct = msg.split(",")[0];
                //QString filepath = msg.split(",")[1].split("://")[1];
                QString filepath = msg.split(",")[1];
                QString filename = filepath.split("/").last().split(".")[0];
            QString wherearewe = things.path()+"/images/"+direct+"/"+filename+".jpg";



            QImage image;


             QString idata;
            if(image.load(filepath) == true) {
                QByteArray imagearray;
                QBuffer buff(&imagearray);
                buff.open( QIODevice::WriteOnly );
                image.save(&buff,"JPEG");
                //image.save(things.path()+"/images/"+direct+"/"+filename+".jpg","JPG");
                idata = imagearray.toBase64();
                buff.close();
                imagearray.clear();

            }

             //idata = msg.split(",")[2]+filename;

            m_message = wherearewe+":;:"+idata+":;:"+filename;

    }

    void directory(QString msg) {

        QString home = QDir::homePath();
        QString data = QStandardPaths::writableLocation(QStandardPaths::DataLocation);

            QDir things(data);
            QString avatarpath =things.path()+"/images/avatar/";
            QString samplepath =things.path()+"/images/sample/";
            QString librarypath =things.path()+"/images/library/";
            QString coverspath =things.path()+"/images/covers/";
            QString otherspath =things.path()+"/images/others/";
            things.mkpath(avatarpath);
            things.mkpath(samplepath);
            things.mkpath(librarypath);
            things.mkpath(coverspath);
            things.mkpath(otherspath);

            m_message = avatarpath+","+samplepath+","+librarypath+","+otherspath+"\n";

    }

    void image_make(QString msg) {


            QImage image;

            QString theimage= msg.split(":;:")[1];
            QString thefile=msg.split(":;:")[0];

            if(image.load(thefile) != true) {

           image.loadFromData(QByteArray::fromBase64(theimage.toLocal8Bit()),"JPEG");

           image.save(thefile);

            }

            the_image =theimage;

    }



   void upload(QString msg) {

        QString imagefile = msg.split(',')[1];
        QString type = msg.split(',')[0];

        QImage image;


         QString data;
        if(image.load(imagefile) == true) {
            QByteArray imagearray;
            QBuffer buff(&imagearray);
            buff.open( QIODevice::WriteOnly );
            image.save(&buff, "JPEG");
            data = imagearray.toBase64();
            buff.close();
            imagearray.clear();


        }

        m_message = data;

    }

    QString the_image;
    QString m_message;
};

#endif // MYTYPE_H


