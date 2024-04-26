#!/bin/bash

npm install
npm run build
npx cap add android
npx cap sync android
# copy web assets
npx cap copy

cd android

# Alternative : open project in Android Studio to build and test
chmod +x gradlew
./gradlew assembleDebug
./gradlew assembleRelease
# In Android Studio : File : profile or debug apk, find file in /app/build/outputs/apk
