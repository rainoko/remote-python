#!/usr/bin/env bash

echo ">>> Installing Oracle InstantClient"


# Install Dependencies
apt-get install -y unzip rpm libaio1 build-essential libaio-dev re2c

SHARED_DIR='/vagrant_data'
INSTANT_ZIP_VERSION='linux.x64-11.2.0.4.0'
INSTANT_WORKING_FOLDER='instantclient_11_2'
INSTANT_MAJOR_VERSION='11'

if [ -f $SHARED_DIR/instantclient-basic-$INSTANT_ZIP_VERSION.zip ]; then
    echo "Found $SHARED_DIR/instantclient-basic-$INSTANT_ZIP_VERSION.zip file."
else
    echo "!!! Missing $SHARED_DIR/instantclient-basic-$INSTANT_ZIP_VERSION.zip file."
    exit 1;
fi

if [ -f $SHARED_DIR/instantclient-sdk-$INSTANT_ZIP_VERSION.zip ]; then
    echo "Found $SHARED_DIR/instantclient-sdk-$INSTANT_ZIP_VERSION.zip file."
else
    echo "!!! Missing $SHARED_DIR/instantclient-sdk-$INSTANT_ZIP_VERSION.zip file."
    exit 1;
fi

cd /tmp
cp $SHARED_DIR/instantclient-* .

cd /opt
if [ -d /opt/oracle ]; then
    sudo rm -Rf oracle
fi

sudo mkdir oracle
cd /opt/oracle
sudo unzip /tmp/instantclient-basic-$INSTANT_ZIP_VERSION.zip
sudo unzip /tmp/instantclient-sdk-$INSTANT_ZIP_VERSION.zip
sudo ln -s /opt/oracle/$INSTANT_WORKING_FOLDER /opt/oracle/instantclient
sudo cp -R /opt/oracle/$INSTANT_WORKING_FOLDER/sdk/* /opt/oracle/$INSTANT_WORKING_FOLDER

cd /opt/oracle/$INSTANT_WORKING_FOLDER
sudo cp sdk/include/* .

sudo ln -s libclntshcore.so.$INSTANT_MAJOR_VERSION.1 libclntshcore.so
sudo ln -s libclntsh.so.$INSTANT_MAJOR_VERSION.1 libclntsh.so
sudo ln -s libocci.so.$INSTANT_MAJOR_VERSION.1 libocci.so
sudo ln -s libnnz$INSTANT_MAJOR_VERSION.so libnnz.so

echo "export LD_LIBRARY_PATH=/opt/oracle/instantclient"

sudo -u vagrant touch /home/vagrant/.ssh/environment
sudo -u vagrant echo "export LD_LIBRARY_PATH=/opt/oracle/instantclient" >> /home/vagrant/.bashrc
sudo -u vagrant echo "export ORACLE_HOME=/opt/oracle/instantclient" >> /home/vagrant/.bashrc
#source /home/vagrant/.bashrc && [ -z "$ORACLE_HOME" ] && sudo -u vagrant echo "export ORACLE_HOME=/opt/oracle/instantclient" >> /home/vagrant/.bashrc

#sed -e "s/.../.../" /dir/file > /dir/temp_file

echo "DONE!"
#sudo echo '/opt/oracle/instantclient/' | sudo tee -a /etc/ld.so.conf.d/oracle_instant_client.conf
#sudo ldconfig
#
#sudo chown -R root:www-data /opt/oracle