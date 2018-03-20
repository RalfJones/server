#!/bin/bash

echo "Waiting for Nextcloud servers to become available"
until curl --silent http://acceptance-ui-php-master > /dev/null && curl --silent http://acceptance-ui-php:8081 > /dev/null
do
    sleep 2
done

node writeConfig.js
./node_modules/.bin/mocha test/installSpec.js --timeout 20000
./node_modules/.bin/mocha test/loginSpec.js --timeout 20000
./node_modules/.bin/mocha test/settingsSpec.js --timeout 20000
./node_modules/.bin/mocha test/publicSpec.js --timeout 20000
