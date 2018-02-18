#!/bin/bash

echo -e "> Updating time&date..."
sudo systemsetup setusingnetworktime off > /dev/null 2>&1
sudo ntpdate -u time.apple.com > /dev/null 2>&1

echo -e "> Updating CA cert..."
curl -kfsSL curl.haxx.se/ca/cacert.pem -o "$(ruby -ropenssl -e 'puts OpenSSL::X509::DEFAULT_CERT_FILE')"

echo -e "> CPU:"
sysctl -n machdep.cpu.brand_string

echo -e "> Swift version:"
xcrun swift -version

echo -e "> Xcodebuild version:"
xcodebuild -version

# 
PODS_ARCHIVE="Pods.tar.bz2"
GEMS_ARCHIVE="Gems.tar.bz2"
CACHE_PATH="/mnt/cache/${CI_RUNNER_ID}/${CI_PROJECT_NAME}"

if [ -e ${CACHE_PATH}/${PODS_ARCHIVE} ]
then
	echo "> Loading pods cache..."
	time cp ${CACHE_PATH}/${PODS_ARCHIVE} $PODS_ARCHIVE
	time openssl enc -aes-256-cbc -k $AUTO_CLOSE_TOKEN -d -in $PODS_ARCHIVE | pbzip2 -dc | tar xf -
fi

if [ -e ${CACHE_PATH}/${GEMS_ARCHIVE} ]
then
	echo "> Loading gems cache..."
	time cp ${CACHE_PATH}/${GEMS_ARCHIVE} $GEMS_ARCHIVE
	time openssl enc -aes-256-cbc -k $AUTO_CLOSE_TOKEN -d -in $GEMS_ARCHIVE | pbzip2 -dc | tar xf -
fi

# print transfered data
ls -lah *.bz2
