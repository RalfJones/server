#!/bin/bash

echo "Waiting for Nextcloud servers to become available"
until curl --silent http://acceptance-ui-php:8080 && curl --silent http://acceptance-ui-php:8081
do
    sleep 2
done

node writeConfig.js
./node_modules/.bin/mocha test/installSpec.js --reporter json --timeout 20000
./node_modules/.bin/mocha test/loginSpec.js --reporter json --timeout 20000
./node_modules/.bin/mocha test/settingsSpec.js --reporter json --timeout 20000
./node_modules/.bin/mocha test/publicSpec.js --reporter json --timeout 20000
