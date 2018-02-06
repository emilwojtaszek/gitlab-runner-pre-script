#!/bin/bash

echo -e "> Updating CA cert..."
curl -fsSL curl.haxx.se/ca/cacert.pem -o "$(ruby -ropenssl -e 'puts OpenSSL::X509::DEFAULT_CERT_FILE')"

echo -e "> CPU:"
sysctl -n machdep.cpu.brand_string

echo -e "> Swift version:"
xcrun swift -version

echo -e "> Xcodebuild version:"
xcodebuild -version

echo -e "> Updating date:"
sudo ntpdate -u time.apple.com