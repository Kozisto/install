#!/bin/sh
BUILDDIR=~/TheGCcoin2
DEPS=~/build/deps/local/lib/
QTPLATFORM=/usr/lib/x86_64-linux-gnu/qt5/plugins/platforms 
mkdir $BUILDDIR
cp ~/build/TheGCCcoin-source-code/TheGCCcoin-Qt $BUILDDIR/
cp ~/build/TheGCCcoin-source-code/qrc_bitcoin.cpp $BUILDDIR/
cd $BUILDDIR
cp -r $QTPLATFORM .
ldd TheGCCcoin-Qt | grep "=> /" | awk '{print $3}' | xargs -I '{}' cp -v '{}' ./
ldd TheGCCcoin-Qt | grep "=> not found" | awk '{print $1}' | xargs -I '{}' cp -v "$DEPS{}" ./

echo "#/bin/sh" >> run.sh
echo 'export LD_LIBRARY_PATH=".:$LD_LIBRARY_PATH"' >> run.sh
echo './"TheGCCcoin-Qt"' >> run.sh
chmod +x run.sh
